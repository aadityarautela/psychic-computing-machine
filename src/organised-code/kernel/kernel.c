#include "../drivers/screen.h"

void main() {
  cls();
  kprint_at("XXX", 0, 0);
  kprint_at("This text spans ", 10, 10);
  // kprint_at("There is a line \n break", 0, 20);
  // kprint("There is a line\nbreak");
  // kprint_at("What happens when we run out of space?", 45, 24);
}