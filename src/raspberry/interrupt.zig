comptime {
    asm (
        \\.macro handle_invalid_entry type
        \\mov	x0, #\type
        \\mrs	x1, esr_el1
        \\mrs	x2, elr_el1
        \\bl	show_invalid_entry_message
        \\.endm
        \\.macro	ventry	label
        \\.align	7
        \\b	\label
        \\.endm
        \\
        \\.align	11
        \\.globl vectors 
        \\vectors:
        \\    ventry	sync_invalid_el1t
        \\    ventry	irq_invalid_el1t
        \\    ventry	fiq_invalid_el1t
        \\    ventry	error_invalid_el1t
        \\    ventry	sync_invalid_el1h
        \\    ventry	el1_irq
        \\    ventry	fiq_invalid_el1h
        \\    ventry	error_invalid_el1h
        \\    ventry	sync_invalid_el0_64
        \\    ventry	irq_invalid_el0_64
        \\    ventry	fiq_invalid_el0_64
        \\    ventry	error_invalid_el0_64
        \\    ventry	sync_invalid_el0_32
        \\    ventry	irq_invalid_el0_32
        \\    ventry	fiq_invalid_el0_32
        \\    ventry	error_invalid_el0_32
        \\sync_invalid_el1t:
        \\	handle_invalid_entry  0
        \\irq_invalid_el1t:
        \\	handle_invalid_entry  1
        \\fiq_invalid_el1t:
        \\	handle_invalid_entry  2
        \\error_invalid_el1t:
        \\	handle_invalid_entry  3
        \\sync_invalid_el1h:
        \\	handle_invalid_entry  4
        \\fiq_invalid_el1h:
        \\	handle_invalid_entry  5
        \\error_invalid_el1h:
        \\	handle_invalid_entry  6
        \\sync_invalid_el0_64:
        \\	handle_invalid_entry  7
        \\irq_invalid_el0_64:
        \\	handle_invalid_entry  8
        \\fiq_invalid_el0_64:
        \\	handle_invalid_entry  9
        \\error_invalid_el0_64:
        \\	handle_invalid_entry  10
        \\sync_invalid_el0_32:
        \\	handle_invalid_entry  11
        \\irq_invalid_el0_32:
        \\	handle_invalid_entry  12
        \\fiq_invalid_el0_32:
        \\	handle_invalid_entry  13
        \\error_invalid_el0_32:
        \\	handle_invalid_entry  14
        \\el1_irq:
        \\	handle_invalid_entry  15
    );
}

pub export fn show_invalid_entry_message(errCode: u32) void {}
