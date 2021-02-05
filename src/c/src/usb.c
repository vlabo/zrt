#include "usb.h"
#include "arm_cm4.h"

#include "buffers.h"

#define PID_OUT   0x1
#define PID_IN    0x9
#define PID_SOF   0x5
#define PID_SETUP 0xd

#define ENDP0_SIZE 64
#define ENDP1_SIZE 64

typedef struct {
    union {
        struct {
            uint8_t bmRequestType;
            uint8_t bRequest;
        };
        uint16_t wRequestAndType;
    };
    uint16_t wValue;
    uint16_t wIndex;
    uint16_t wLength;
} setup_t;

typedef struct {
    uint8_t bLength;
    uint8_t bDescriptorType;
    uint16_t wString[];
} str_descriptor_t;

typedef struct {
    uint16_t wValue;
    uint16_t wIndex;
    const void* addr;
    uint8_t length;
} descriptor_entry_t;

#define BDT_BC_SHIFT   16
#define BDT_OWN_MASK   0x80
#define BDT_DATA1_MASK 0x40
#define BDT_KEEP_MASK  0x20
#define BDT_NINC_MASK  0x10
#define BDT_DTS_MASK   0x08
#define BDT_STALL_MASK 0x04

#define BDT_DESC(count, data) ((count << BDT_BC_SHIFT) | BDT_OWN_MASK | (data ? BDT_DATA1_MASK : 0x00) | BDT_DTS_MASK)
#define BDT_PID(desc) ((desc >> 2) & 0xF)

/**
 * Buffer Descriptor Table entry
 * There are two entries per direction per endpoint:
 *   In  Even/Odd
 *   Out Even/Odd
 * A bidirectional endpoint would then need 4 entries
 */
typedef struct {
    uint32_t desc;
    void* addr;
} bdt_t;

// we enforce a max of 15 endpoints (15 + 1 control = 16)
#define USB_N_ENDPOINTS 15

//determines an appropriate BDT index for the given conditions (see fig. 41-3)
#define RX 0
#define TX 1
#define EVEN 0
#define ODD  1
#define BDT_INDEX(endpoint, tx, odd) ((endpoint << 2) | (tx << 1) | odd)

/**
 * Buffer descriptor table, aligned to a 512-byte boundary (see linker file)
 */
__attribute__ ((aligned(512), used))
static bdt_t table[(USB_N_ENDPOINTS + 1)*4]; //max endpoints is 15 + 1 control

/**
 * Endpoint 0 receive buffers (2x64 bytes)
 */
static uint8_t endp0_rx[2][ENDP0_SIZE];

static const uint8_t* endp0_tx_dataptr = NULL; //pointer to current transmit chunk
static uint16_t endp0_tx_datalen = 0; //length of data remaining to send

/**
 * Device descriptor
 * NOTE: This cannot be const because without additional attributes, it will
 * not be placed in a part of memory that the usb subsystem can access. I
 * have a suspicion that this location is somewhere in flash, but not copied
 * to RAM.
 */
static uint8_t dev_descriptor[] = {
    18, //bLength
    1, //bDescriptorType
    0x00, 0x02, //bcdUSB
    0xff, //bDeviceClass
    0x00, //bDeviceSubClass
    0x00, //bDeviceProtocl
    ENDP0_SIZE, //bMaxPacketSize0
    0xc0, 0x16, //idVendor
    0xdc, 0x05, //idProduct
    0x01, 0x00, //bcdDevice
    1, //iManufacturer
    2, //iProduct
    0, //iSerialNumber,
    1, //bNumConfigurations
};

/**
 * Configuration descriptor
 * NOTE: Same thing about const applies here
 */
static uint8_t cfg_descriptor[] = {
    9, //bLength
    2, //bDescriptorType
    9 + 9 + 7, 0x00, //wTotalLength
    1, //bNumInterfaces
    1, //bConfigurationValue,
    0, //iConfiguration
    0x80, //bmAttributes
    250, //bMaxPower
    /* INTERFACE 0 BEGIN */
    9, //bLength
    4, //bDescriptorType
    0, //bInterfaceNumber
    0, //bAlternateSetting
    1, //bNumEndpoints
    0xff, //bInterfaceClass
    0x00, //bInterfaceSubClass,
    0x00, //bInterfaceProtocol
    0, //iInterface
        /* INTERFACE 0, ENDPOINT 1 BEGIN */
        7, //bLength
        5, //bDescriptorType,
        0x81, //bEndpointAddress,
        0x02, //bmAttributes, bulk endpoint
        ENDP1_SIZE, 0x00, //wMaxPacketSize,
        0 //bInterval
        /* INTERFACE 0, ENDPOINT 1 END */
    /* INTERFACE 0 END */
};

static str_descriptor_t lang_descriptor = {
    .bLength = 4,
    .bDescriptorType = 3,
    .wString = { 0x0409 } //english (US)
};

static str_descriptor_t manuf_descriptor = {
    .bLength = 2 + 15 * 2,
    .bDescriptorType = 3,
    .wString = {'k','e','v','i', 'n', 'c', 'u', 'z', 'n', 'e', 'r', '.', 'c', 'o', 'm'}
};

static str_descriptor_t product_descriptor = {
    .bLength = 2 + 15 * 2,
    .bDescriptorType = 3,
    .wString = {'T', 'e', 'e', 'n', 's', 'y', '3', '.', '1', ' ', 'S', 'c', 'o', 'p', 'e' }
};

static const descriptor_entry_t descriptors[] = {
    { 0x0100, 0x0000, dev_descriptor, sizeof(dev_descriptor) },
    { 0x0200, 0x0000, &cfg_descriptor, sizeof(cfg_descriptor) },
    { 0x0300, 0x0000, &lang_descriptor, 4 },
    { 0x0301, 0x0409, &manuf_descriptor, 2 + 15 * 2 },
    { 0x0302, 0x0409, &product_descriptor, 2 + 15 * 2 },
    { 0x0000, 0x0000, NULL, 0 }
};

static uint8_t endp0_odd, endp0_data = 0;
static void usb_endp0_transmit(const void* data, uint8_t length)
{
    table[BDT_INDEX(0, TX, endp0_odd)].addr = (void *)data;
    table[BDT_INDEX(0, TX, endp0_odd)].desc = BDT_DESC(length, endp0_data);
    //toggle the odd and data bits
    endp0_odd ^= 1;
    endp0_data ^= 1;
}

/**
 * Endpoint 0 setup handler
 */
static void usb_endp0_handle_setup(setup_t* packet)
{
    const descriptor_entry_t* entry;
    const uint8_t* data = NULL;
    uint8_t data_length = 0;
    uint32_t size = 0;


    switch(packet->wRequestAndType)
    {
    case 0x0500: //set address (wait for IN packet)
        break;
    case 0x0900: //set configuration
        //we only have one configuration at this time
        break;
    case 0x0680: //get descriptor
    case 0x0681:
        for (entry = descriptors; 1; entry++)
        {
            if (entry->addr == NULL)
                break;

            if (packet->wValue == entry->wValue && packet->wIndex == entry->wIndex)
            {
                //this is the descriptor to send
                data = entry->addr;
                data_length = entry->length;
                goto send;
            }
        }
        goto stall;
        break;
    default:
        goto stall;
    }

    //if we are sent here, we need to send some data
    send:
        //truncate the data length to whatever the setup packet is expecting
        if (data_length > packet->wLength)
            data_length = packet->wLength;

        //transmit 1st chunk
        size = data_length;
        if (size > ENDP0_SIZE)
            size = ENDP0_SIZE;
        usb_endp0_transmit(data, size);
        data += size; //move the pointer down
        data_length -= size; //move the size down
        if (data_length == 0 && size < ENDP0_SIZE)
            return; //all done!

        //transmit 2nd chunk
        size = data_length;
        if (size > ENDP0_SIZE)
            size = ENDP0_SIZE;
        usb_endp0_transmit(data, size);
        data += size; //move the pointer down
        data_length -= size; //move the size down
        if (data_length == 0 && size < ENDP0_SIZE)
            return; //all done!

        //if any data remains to be transmitted, we need to store it
        endp0_tx_dataptr = data;
        endp0_tx_datalen = data_length;
        return;

    //if we make it here, we are not able to send data and have stalled
    stall:
        USB0_ENDPT0 = USB_ENDPT_EPSTALL_MASK | USB_ENDPT_EPRXEN_MASK | USB_ENDPT_EPTXEN_MASK | USB_ENDPT_EPHSHK_MASK;
}

/**
 * Endpoint 0 handler
 */
void usb_endp0_handler(uint8_t stat)
{
    static setup_t last_setup;

    const uint8_t* data = NULL;
    uint32_t size = 0;

    //determine which bdt we are looking at here
    bdt_t* bdt = &table[BDT_INDEX(0, (stat & USB_STAT_TX_MASK) >> USB_STAT_TX_SHIFT, (stat & USB_STAT_ODD_MASK) >> USB_STAT_ODD_SHIFT)];

    switch (BDT_PID(bdt->desc))
    {
    case PID_SETUP:
        //extract the setup token
		last_setup = *((setup_t*)(bdt->addr));

		//we are now done with the buffer
        bdt->desc = BDT_DESC(ENDP0_SIZE, 1);

        //clear any pending IN stuff
        table[BDT_INDEX(0, TX, EVEN)].desc = 0;
		table[BDT_INDEX(0, TX, ODD)].desc = 0;
        endp0_data = 1;

        //cast the data into our setup type and run the setup
        usb_endp0_handle_setup(&last_setup);//&last_setup);

        //unfreeze this endpoint
        USB0_CTL = USB_CTL_USBENSOFEN_MASK;
        break;
    case PID_IN:
        //continue sending any pending transmit data
        data = endp0_tx_dataptr;
		if (data)
        {
			size = endp0_tx_datalen;
			if (size > ENDP0_SIZE)
                size = ENDP0_SIZE;
			usb_endp0_transmit(data, size);
			data += size;
			endp0_tx_datalen -= size;
			endp0_tx_dataptr = (endp0_tx_datalen > 0 || size == ENDP0_SIZE) ? data : NULL;
		}

        if (last_setup.wRequestAndType == 0x0500)
        {
            USB0_ADDR = last_setup.wValue;
        }
        break;
    case PID_OUT:
        //nothing to do here..just give the buffer back
        bdt->desc = BDT_DESC(ENDP0_SIZE, 1);
        break;
    case PID_SOF:
        break;
    }

    USB0_CTL = USB_CTL_USBENSOFEN_MASK;
}

static uint8_t endp1_odd, endp1_data1 = 0;
static void usb_endp1_transmit(const void* data, uint8_t length)
{
    table[BDT_INDEX(1, TX, endp0_odd)].addr = (void *)data;
    table[BDT_INDEX(1, TX, endp0_odd)].desc = BDT_DESC(length, endp1_data1);
    //toggle the odd and data bits
    endp1_odd ^= 1;
    endp1_data1 ^= 1;
}

/**
 * Endpoint 1 handler
 */
void usb_endp1_handler(uint8_t stat)
{
    static uint8_t* buffer = NULL;
    static uint16_t length = 0;

    //determine which bdt we are looking at here
    bdt_t* bdt = &table[BDT_INDEX(0, (stat & USB_STAT_TX_MASK) >> USB_STAT_TX_SHIFT, (stat & USB_STAT_ODD_MASK) >> USB_STAT_ODD_SHIFT)];

    switch (BDT_PID(bdt->desc))
    {
    case PID_SETUP:
        //we are now done with the buffer
        bdt->desc = BDT_DESC(ENDP1_SIZE, 1);

        //clear any pending IN stuff
        table[BDT_INDEX(1, TX, EVEN)].desc = 0;
		table[BDT_INDEX(1, TX, ODD)].desc = 0;
        endp1_data1 = 1;
        //unfreeze this endpoint
        USB0_CTL = USB_CTL_USBENSOFEN_MASK;
    case PID_IN:
        if (buffer)
        {

        }
        break;
    }
}

static void (*handlers[16])(uint8_t) = {
    usb_endp0_handler,
    usb_endp1_handler,
    usb_endp2_handler,
    usb_endp3_handler,
    usb_endp4_handler,
    usb_endp5_handler,
    usb_endp6_handler,
    usb_endp7_handler,
    usb_endp8_handler,
    usb_endp9_handler,
    usb_endp10_handler,
    usb_endp11_handler,
    usb_endp12_handler,
    usb_endp13_handler,
    usb_endp14_handler,
    usb_endp15_handler,
};

/**
 * Default handler for USB endpoints that does nothing
 */
static void usb_endp_default_handler(uint8_t stat) { }

//weak aliases as "defaults" for the usb endpoint handlers
void usb_endp2_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp3_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp4_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp5_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp6_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp7_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp8_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp9_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp10_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp11_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp12_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp13_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp14_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));
void usb_endp15_handler(uint8_t) __attribute__((weak, alias("usb_endp_default_handler")));

int32_t  pll_init(int8_t  prdiv_val, int8_t  vdiv_val)
{
	uint8_t		frdiv_val;
	uint8_t		temp_reg;
	uint8_t		prdiv;
	uint8_t		vdiv;
	int16_t		i;
	int32_t		ref_freq;
	int32_t		pll_freq;
	uint32_t	crystal_val;
	uint8_t		hgo_val;
	uint8_t		erefs_val;

	// check if in FEI mode
	if (!((((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) == 0x0) && // check CLKS mux has selcted FLL output
      (MCG_S & MCG_S_IREFST_MASK) &&                          // check FLL ref is internal ref clk
      (!(MCG_S & MCG_S_PLLST_MASK))))                         // check PLLS mux has selected FLL
	{
		return 0x1;                                           // return error code
	}

/*
 *  Removed original checks on crystal frequency; Teensy 3.x always uses 16 MHz
 *  crystal as external source (crystal_val = 16000000).
 */
	crystal_val = 16000000;
/*
 *  Removed check of high-gain flag; Teensy 3.x always uses low-power (HGO = 0).
 */
	hgo_val = 0;
/*
 *  Removed check of external select; Teensy 3.x always uses external crystal oscillator
 *  (erefs_val = 1).
 */
	erefs_val = 1;

	// Check PLL divider settings are within spec.
	if ((prdiv_val < 1) || (prdiv_val > 25)) {return 0x41;}
	if ((vdiv_val < 24) || (vdiv_val > 55)) {return 0x42;}

	// Check PLL reference clock frequency is within spec.
	ref_freq = crystal_val / prdiv_val;
	if ((ref_freq < 2000000) || (ref_freq > 4000000)) {return 0x43;}

	// Check PLL output frequency is within spec.
	pll_freq = (crystal_val / prdiv_val) * vdiv_val;
	if ((pll_freq < 48000000) || (pll_freq > 100000000)) {return 0x45;}

	// configure the MCG_C2 register
	// the RANGE value is determined by the external frequency. Since the RANGE parameter affects the FRDIV divide value
	// it still needs to be set correctly even if the oscillator is not being used

	temp_reg = MCG_C2;
	temp_reg &= ~(MCG_C2_RANGE0_MASK | MCG_C2_HGO0_MASK | MCG_C2_EREFS0_MASK); // clear fields before writing new values
	temp_reg |= (MCG_C2_RANGE0(2) | (hgo_val << MCG_C2_HGO0_SHIFT) | (erefs_val << MCG_C2_EREFS0_SHIFT));
	MCG_C2 = temp_reg;

/*
 *  Removed tests around frdiv_val.  The frdiv_val is fixed at 4 because the Teensy
 *  always uses a 16 MHz crystal.
 */
	frdiv_val = 4;

/*
 *  Select external oscillator and Reference Divider and clear IREFS to start ext osc
 *  If IRCLK is required it must be enabled outside of this driver, existing state
 *  will be maintained.
 *  CLKS=2, FRDIV=frdiv_val, IREFS=0, IRCLKEN=0, IREFSTEN=0
 */
	temp_reg = MCG_C1;
	temp_reg &= ~(MCG_C1_CLKS_MASK | MCG_C1_FRDIV_MASK | MCG_C1_IREFS_MASK); // Clear values in these fields
	temp_reg = MCG_C1_CLKS(2) | MCG_C1_FRDIV(frdiv_val); // Set the required CLKS and FRDIV values
	MCG_C1 = temp_reg;

/*
 *  if the external oscillator is used need to wait for OSCINIT to set
 */
	for (i = 0 ; i < 10000 ; i++)
	{
		if (MCG_S & MCG_S_OSCINIT0_MASK) break; // jump out early if OSCINIT sets before loop finishes
	}
	if (!(MCG_S & MCG_S_OSCINIT0_MASK)) return 0x23; // check bit is really set and return with error if not set

/*
 *  Wait for clock status bits to show clock source is ext ref clk
 */
	for (i = 0 ; i < 2000 ; i++)
	{
		if (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) == 0x2) break; // jump out early if CLKST shows EXT CLK slected before loop finishes
	}
	if (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x2) return 0x1A; // check EXT CLK is really selected and return with error if not

/*
 *  Now in FBE
 *  It is recommended that the clock monitor is enabled when using an external clock
 *  as the clock source/reference.
 *  It is enabled here but can be removed if this is not required.
 */
	MCG_C6 |= MCG_C6_CME0_MASK;

/*
 *  Configure PLL
 *  Configure MCG_C5
 *  If the PLL is to run in STOP mode then the PLLSTEN bit needs to be OR'ed
 *  in here or in user code.
 */
	temp_reg = MCG_C5;
	temp_reg &= ~MCG_C5_PRDIV0_MASK;
	temp_reg |= MCG_C5_PRDIV0(prdiv_val - 1);    //set PLL ref divider
	MCG_C5 = temp_reg;

/*
 *  Configure MCG_C6
 *  The PLLS bit is set to enable the PLL, MCGOUT still sourced from ext ref clk
 *  The loss of lock interrupt can be enabled by seperately OR'ing in the LOLIE bit in MCG_C6
 */
	temp_reg = MCG_C6;					// store present C6 value
	temp_reg &= ~MCG_C6_VDIV0_MASK;		// clear VDIV settings
	temp_reg |= MCG_C6_PLLS_MASK | MCG_C6_VDIV0(vdiv_val - 24); // write new VDIV and enable PLL
	MCG_C6 = temp_reg;					// update MCG_C6

/*
 *  wait for PLLST status bit to set
 */
	for (i = 0 ; i < 2000 ; i++)
	{
		if (MCG_S & MCG_S_PLLST_MASK) break; // jump out early if PLLST sets before loop finishes
	}
	if (!(MCG_S & MCG_S_PLLST_MASK)) return 0x16; // check bit is really set and return with error if not set

/*
 *  Wait for LOCK bit to set
 */
	for (i = 0 ; i < 2000 ; i++)
	{
		if (MCG_S & MCG_S_LOCK0_MASK) break; // jump out early if LOCK sets before loop finishes
	}
	if (!(MCG_S & MCG_S_LOCK0_MASK)) return 0x44; // check bit is really set and return with error if not set

/*
 *  Use actual PLL settings to calculate PLL frequency
 */
	prdiv = ((MCG_C5 & MCG_C5_PRDIV0_MASK) + 1);
	vdiv = ((MCG_C6 & MCG_C6_VDIV0_MASK) + 24);

/*
 *  now in PBE
 */
	MCG_C1 &= ~MCG_C1_CLKS_MASK; // clear CLKS to switch CLKS mux to select PLL as MCG_OUT

/*
 *  Wait for clock status bits to update
 */
	for (i = 0 ; i < 2000 ; i++)
	{
	if (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) == 0x3) break; // jump out early if CLKST = 3 before loop finishes
	}
	if (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x3) return 0x1B; // check CLKST is set correctly and return with error if not

/*
 *  Now in PEE
 */
	return ((crystal_val / prdiv) * vdiv); //MCGOUT equals PLL output frequency
} // pll_init


void usb_init(void)
{

    SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK
            | SIM_SCGC5_PORTB_MASK
            | SIM_SCGC5_PORTC_MASK
            | SIM_SCGC5_PORTD_MASK
            | SIM_SCGC5_PORTE_MASK );

    /* Ramp up the system clock
    * Set the system dividers
    * NOTE: The PLL init will not configure the system clock dividers,
    * so they must be configured appropriately before calling the PLL
    * init function to ensure that clocks remain in valid ranges.
    */
    SIM_CLKDIV1 = ( 0
                    | SIM_CLKDIV1_OUTDIV1(0)
                    | SIM_CLKDIV1_OUTDIV2(1)
                    | SIM_CLKDIV1_OUTDIV4(2) );

    /* releases hold with ACKISO:  Only has an effect if recovering from VLLS1, VLLS2, or VLLS3
    * if ACKISO is set you must clear ackiso before calling pll_init
    * or pll init hangs waiting for OSC to initialize.
    * if osc enabled in low power modes - enable it first before ack.
    * if I/O needs to be maintained without glitches enable outputs and modules first before ack.
    */
    if (PMC_REGSC &  PMC_REGSC_ACKISO_MASK)
        PMC_REGSC |= PMC_REGSC_ACKISO_MASK;

    /* Initialize PLL
    * PLL will be the source for MCG CLKOUT so the core, system, and flash clocks
    * are derived from it.
    */
    pll_init(PRDIV_VAL, VDIV_VAL);	// Use the output from this PLL as the MCGOUT

    uint32_t i;

    //reset the buffer descriptors
    for (i = 0; i < (USB_N_ENDPOINTS + 1) * 4; i++)
    {
        table[i].desc = 0;
        table[i].addr = 0;
    }

    //1: Select clock source
    SIM_SOPT2 |= SIM_SOPT2_USBSRC_MASK | SIM_SOPT2_PLLFLLSEL_MASK; //we use MCGPLLCLK divided by USB fractional divider
    SIM_CLKDIV2 = SIM_CLKDIV2_USBDIV(1);// SIM_CLKDIV2_USBDIV(2) | SIM_CLKDIV2_USBFRAC_MASK; //(USBFRAC + 1)/(USBDIV + 1) = (1 + 1)/(2 + 1) = 2/3 for 72Mhz clock

    //2: Gate USB clock
    SIM_SCGC4 |= SIM_SCGC4_USBOTG_MASK;

    //3: Software USB module reset
    USB0_USBTRC0 |= USB_USBTRC0_USBRESET_MASK;
    while (USB0_USBTRC0 & USB_USBTRC0_USBRESET_MASK);

    //4: Set BDT base registers
    USB0_BDTPAGE1 = ((uint32_t)table) >> 8;  //bits 15-9
    USB0_BDTPAGE2 = ((uint32_t)table) >> 16; //bits 23-16
    USB0_BDTPAGE3 = ((uint32_t)table) >> 24; //bits 31-24

    //5: Clear all ISR flags and enable weak pull downs
    USB0_ISTAT = 0xFF;
    USB0_ERRSTAT = 0xFF;
    USB0_OTGISTAT = 0xFF;
    USB0_USBTRC0 |= 0x40; //a hint was given that this is an undocumented interrupt bit

    //6: Enable USB reset interrupt
    USB0_CTL = USB_CTL_USBENSOFEN_MASK;
    USB0_USBCTRL = 0;

    USB0_INTEN |= USB_INTEN_USBRSTEN_MASK;
    //NVIC_SET_PRIORITY(IRQ(INT_USB0), 112);
    enable_irq(IRQ(INT_USB0));

    //7: Enable pull-up resistor on D+ (Full speed, 12Mbit/s)
    USB0_CONTROL = USB_CONTROL_DPPULLUPNONOTG_MASK;
}

void USBOTG_IRQHandler(void)
{
    uint8_t status;
    uint8_t stat, endpoint;

    status = USB0_ISTAT;

    if (status & USB_ISTAT_USBRST_MASK)
    {
        //handle USB reset

        //initialize endpoint 0 ping-pong buffers
        USB0_CTL |= USB_CTL_ODDRST_MASK;
        endp0_odd = 0;
        table[BDT_INDEX(0, RX, EVEN)].desc = BDT_DESC(ENDP0_SIZE, 0);
        table[BDT_INDEX(0, RX, EVEN)].addr = endp0_rx[0];
        table[BDT_INDEX(0, RX, ODD)].desc = BDT_DESC(ENDP0_SIZE, 0);
        table[BDT_INDEX(0, RX, ODD)].addr = endp0_rx[1];
        table[BDT_INDEX(0, TX, EVEN)].desc = 0;
        table[BDT_INDEX(0, TX, ODD)].desc = 0;

        //initialize endpoint0 to 0x0d (41.5.23)
        //transmit, recieve, and handshake
        USB0_ENDPT0 = USB_ENDPT_EPRXEN_MASK | USB_ENDPT_EPTXEN_MASK | USB_ENDPT_EPHSHK_MASK;

        //clear all interrupts...this is a reset
        USB0_ERRSTAT = 0xff;
        USB0_ISTAT = 0xff;

        //after reset, we are address 0, per USB spec
        USB0_ADDR = 0;

        //all necessary interrupts are now active
        USB0_ERREN = 0xFF;
        USB0_INTEN = USB_INTEN_USBRSTEN_MASK | USB_INTEN_ERROREN_MASK |
            USB_INTEN_SOFTOKEN_MASK | USB_INTEN_TOKDNEEN_MASK |
            USB_INTEN_SLEEPEN_MASK | USB_INTEN_STALLEN_MASK;

        return;
    }
    if (status & USB_ISTAT_ERROR_MASK)
    {
        //handle error
        USB0_ERRSTAT = USB0_ERRSTAT;
        USB0_ISTAT = USB_ISTAT_ERROR_MASK;
    }
    if (status & USB_ISTAT_SOFTOK_MASK)
    {
        //handle start of frame token
        USB0_ISTAT = USB_ISTAT_SOFTOK_MASK;
    }
    if (status & USB_ISTAT_TOKDNE_MASK)
    {
        //handle completion of current token being processed
        stat = USB0_STAT;
        endpoint = stat >> 4;
        handlers[endpoint & 0xf](stat);

        USB0_ISTAT = USB_ISTAT_TOKDNE_MASK;
    }
    if (status & USB_ISTAT_SLEEP_MASK)
    {
        //handle USB sleep
        USB0_ISTAT = USB_ISTAT_SLEEP_MASK;
    }
    if (status & USB_ISTAT_STALL_MASK)
    {
        //handle usb stall
        USB0_ISTAT = USB_ISTAT_STALL_MASK;
    }
}
