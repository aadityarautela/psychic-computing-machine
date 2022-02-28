#include "../cpu/idt.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "util.h"

void main() {
  isr_install();
  __asm__ __volatile__("int $2");
  __asm__ __volatile__("int $3");
}