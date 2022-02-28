#include "idt.h"
#include "../kernel/util.h"

void set_idt_gate(int n, u32 handler) {
  idt[n].low_offset = low_16(handler);
  idt[n].sel = KERNEL_CODE_SEGMENT;
  idt[n].always_zero = 0;
  idt[n].flags = 0x8E;
  idt[n].high_offset = high_16(handler);
}

void set_idt() {
  idt_reg.base = (u32)&idt;
  idt_reg.limit = IDT_ENTRIES * sizeof(idt_gate_t) - 1;
  // DO NOT LOAD &idt, always load &idt_reg
  __asm__ __volatile__("lidtl (%0)" : : "r"(&idt_reg));
}