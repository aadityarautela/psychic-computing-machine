#pragma once

#include "types.h"

// Segment Selector
#define KERNEL_CODE_SEGMENT 0x08

// Interrupt Gate (Handler)
typedef struct {
  u16 low_offset; // lower 16bits of handler function addr
  u16 sel;        // kernel segment selector
  u8 always_zero;
  // Bits
  // Bit 7: Interrupt present
  // Bits 6-5: Privilege level of caller (0=>kernel, 3=>user...)
  // Bit 4: 0 (for interrupt gates)
  // Bits 3-0: 1110 (decimal 14 => 32bit interrupt gate)
  u8 flags;
  u16 high_offset;                    // higher 16bits of handler function addr
} __attribute__((packed)) idt_gate_t; // don't add padding to struct


// pointer to array of interrupt handlers
// "lidt" asm instruction will be used to read
typedef struct {
  u16 limit;
  u32 base;
} __attribute__((packed)) idt_register_t;

#define IDT_ENTRIES 256
idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;

void set_idt_gate(int n, u32 handler);
void set_idt();