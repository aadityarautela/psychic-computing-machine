#include "../drivers/screen.h"

void main() {
  cls();
  kprint_at("XXX", 0, 24);
  kprint_at("This text spans \n two lines", 10, 10);
  kprint_at("RUNNING OUTAAAAAAA SPACEEEEEE\nEEEE", 45, 24);
}