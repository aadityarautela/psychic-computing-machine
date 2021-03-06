#include "isr.h"
#include "../drivers/screen.h"
#include "../kernel/util.h"
#include "idt.h"

void isr_install() {
  set_idt_gate(0, (u32)isr0);
  set_idt_gate(1, (u32)isr1);
  set_idt_gate(2, (u32)isr2);
  set_idt_gate(3, (u32)isr3);
  set_idt_gate(4, (u32)isr4);
  set_idt_gate(5, (u32)isr5);
  set_idt_gate(6, (u32)isr6);
  set_idt_gate(7, (u32)isr7);
  set_idt_gate(8, (u32)isr8);
  set_idt_gate(9, (u32)isr9);
  set_idt_gate(10, (u32)isr10);
  set_idt_gate(11, (u32)isr11);
  set_idt_gate(12, (u32)isr12);
  set_idt_gate(13, (u32)isr13);
  set_idt_gate(14, (u32)isr14);
  set_idt_gate(15, (u32)isr15);
  set_idt_gate(16, (u32)isr16);
  set_idt_gate(17, (u32)isr17);
  set_idt_gate(18, (u32)isr18);
  set_idt_gate(19, (u32)isr19);
  set_idt_gate(20, (u32)isr20);
  set_idt_gate(21, (u32)isr21);
  set_idt_gate(22, (u32)isr22);
  set_idt_gate(23, (u32)isr23);
  set_idt_gate(24, (u32)isr24);
  set_idt_gate(25, (u32)isr25);
  set_idt_gate(26, (u32)isr26);
  set_idt_gate(27, (u32)isr27);
  set_idt_gate(28, (u32)isr28);
  set_idt_gate(29, (u32)isr29);
  set_idt_gate(30, (u32)isr30);
  set_idt_gate(31, (u32)isr31);

  // 8259 PIC Remapping
  port_byte_out(0x20, 0x11); // init command master
  port_byte_out(0xA0, 0x11); // init command slave
  port_byte_out(0x21, 0x20); // vector offset master
  port_byte_out(0xA1, 0x28); // vector offset slave
  port_byte_out(0x21, 0x04); // tells master there's a slave pic at irq2
  port_byte_out(0xA1, 0x02); // tells slave its identity (2)
  port_byte_out(0x21, 0x01); // master 8086 mode
  port_byte_out(0xA1, 0x01); // slave 8086 mode
  port_byte_out(0x21, 0x0);
  port_byte_out(0xA1, 0x0);

  // IRQ installation
  set_idt_gate(IRQ0, (u32)irq0);
  set_idt_gate(IRQ1, (u32)irq1);
  set_idt_gate(IRQ2, (u32)irq2);
  set_idt_gate(IRQ3, (u32)irq3);
  set_idt_gate(IRQ4, (u32)irq4);
  set_idt_gate(IRQ5, (u32)irq5);
  set_idt_gate(IRQ6, (u32)irq6);
  set_idt_gate(IRQ7, (u32)irq7);
  set_idt_gate(IRQ8, (u32)irq8);
  set_idt_gate(IRQ9, (u32)irq9);
  set_idt_gate(IRQ10, (u32)irq10);
  set_idt_gate(IRQ11, (u32)irq11);
  set_idt_gate(IRQ12, (u32)irq12);
  set_idt_gate(IRQ13, (u32)irq13);
  set_idt_gate(IRQ14, (u32)irq14);
  set_idt_gate(IRQ15, (u32)irq15);

  set_idt();
}

char *exception_messages[] = {
    "Division By Zero",
    "Single-step interrupt (Debug)",
    "Non Maskable Interrupt",
    "Breakpoint",
    "Overflow",
    "Bound Range Exceeded",
    "Invalid Opcode",
    "Coprocessor not available",
    "Double Fault",
    "Coprocessor Segment Overrun",
    "Invalid Task State Segment",
    "Segment Not Present",
    "Stack Segment Fault",
    "General Protection Fault",
    "Page Fault",
    "Unknown Interrupt",
    "x87 Floating Point Exception (Coprocessor Fault)",
    "Alignment Check",
    "Machine Check",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved"};

void isr_handler(registers_t r) {
  kprint("Interrupt Received: ");
  char temp[3];
  int_to_ascii(r.int_no, temp);
  kprint(temp);
  kprint("\n");
  kprint(exception_messages[r.int_no]);
  kprint("\n");
}

void irq_handler(registers_t r) {
  // necessary to send EOI(end of instruction) after every
  // interrupt otherwise PIC won't send another interrupt again.
}