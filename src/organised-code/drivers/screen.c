#include "screen.h"
#include "ports.h"
#include "../kernel/util.h"

// private fn decl
int get_cursor_offset();
void set_cursor_offset(int offset);
int print_char(char c, int col, int row, char attr);
int get_offset(int col, int row);
int get_offset_row(int offset);
int get_offset_col(int offset);

/*
 * public kernel api fn
 */

// print msg at location. if col row both -ve, use current offset
void kprint_at(char *message, int col, int row) {
  int offset;
  if (col >= 0 && row >= 0)
    offset = get_offset(col, row);
  else {
    offset = get_cursor_offset();
    row = get_offset_row(offset);
    col = get_offset_col(offset);
  }
  int i = 0;
  while (message[i] != 0) {
    offset = print_char(message[i++], col, row, WHITE_ON_BLACK);
    row = get_offset_row(offset);
    col = get_offset_col(offset);
  }
}

void kprint(char *message) { kprint_at(message, -1, -1); }

/*
 * private kernel api fn
 */

// print fn for kernel, returns offset of the next char
int print_char(char c, int col, int row, char attr) {
  unsigned char *vidmem = (unsigned char *)VIDEO_ADDRESS;
  if (!attr)
    attr = WHITE_ON_BLACK;

  // if invalid coords, print error 'F'
  if (col >= MAX_COLS || row >= MAX_ROWS) {
    vidmem[2 * (MAX_COLS) * (MAX_ROWS)-2] = 'F';
    vidmem[2 * (MAX_COLS) * (MAX_ROWS)-1] = RED_ON_WHITE;
    return get_offset(col, row);
  }

  int offset;
  if (col >= 0 && row >= 0)
    offset = get_offset(col, row);
  else
    offset = get_cursor_offset();
  if (c == '\n') {
    row = get_offset_row(offset);
    offset = get_offset(0, row + 1);
  } else {
    vidmem[offset] = c;
    vidmem[offset + 1] = attr;
    offset += 2;
  }

  // scroll if offset exceeds screen size
  if (offset >= MAX_COLS * MAX_ROWS * 2) {
    int i;
    for (i = 1; i < MAX_ROWS; i++)
      memory_copy(get_offset(0, i) + VIDEO_ADDRESS,
                  get_offset(0, i - 1) + VIDEO_ADDRESS, MAX_COLS*2);
    // blank the last line
    char *last_line = get_offset(0, MAX_ROWS - 1) + VIDEO_ADDRESS;
    for (i = 0; i < MAX_COLS * 2; i++)
      last_line[i] = 0;

    offset -= 2 * MAX_COLS;
  }

  set_cursor_offset(offset);
  return offset;
}

// returns cursor offset
int get_cursor_offset() {
  port_byte_out(REG_SCREEN_CTRL, 14);
  int offset = port_byte_in(REG_SCREEN_DATA) << 8;
  port_byte_out(REG_SCREEN_CTRL, 15);
  offset += port_byte_in(REG_SCREEN_DATA);
  return offset * 2;
}

// sets cursor offset, similar to get_cursor_offset()
void set_cursor_offset(int offset) {
  offset /= 2;
  port_byte_out(REG_SCREEN_CTRL, 14);
  port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
  port_byte_out(REG_SCREEN_CTRL, 15);
  port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset & 0xff));
}

// clear screen by blanking all characters
void cls() {
  int screen_size = MAX_COLS * MAX_ROWS;
  int i;
  char *screen = (char *)VIDEO_ADDRESS;
  for (i = 0; i < screen_size; i++) {
    screen[2 * i] = ' ';
    screen[2 * i + 1] = WHITE_ON_BLACK;
  }
  set_cursor_offset(get_offset(0, 0));
}

int get_offset(int col, int row) { return 2 * (row * MAX_COLS + col); }
int get_offset_row(int offset) { return offset / (2 * MAX_COLS); }
int get_offset_col(int offset) {
  return (offset - (get_offset_row(offset) * 2 * MAX_COLS)) / 2;
}