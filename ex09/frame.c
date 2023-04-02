#include <ctype.h>
#include <stdio.h>
#include <string.h>

size_t
get_max_len(char* str) {
  size_t max_len;
  size_t len;

  max_len = 0;
  while (*str) {
    while (isspace(*str))
      ++str;
    len = 0;
    while (*str && !isspace(*str)) {
      ++str;
      ++len;
    }
    if (max_len < len)
      max_len = len;
  }
  return (max_len);
}

void
repeat_char(char c, size_t len) {
  if (len > 0) {
    printf("%c", c);
    repeat_char(c, len - 1);
  }
}

char*
print_line(char* str, size_t width) {
  if (*str && !isspace(*str)) {
    printf("%c", *str);
    return (print_line(str + 1, width - 1));
  }
  if (width > 0) {
    printf(" ");
    return (print_line(str, width - 1));
  }
  return (str);
}

void
print_internal(char* str, size_t max_len) {
  if (*str) {
    printf("*");
    while (isspace(*str))
      ++str;
    str = print_line(str, max_len);
    printf("*\n");
    print_internal(str, max_len);
  }
}

void
print_frame(char* str) {
  size_t max_len;

  max_len = get_max_len(str);
  repeat_char('*', max_len + 2);
  printf("\n");
  print_internal(str, max_len);
  repeat_char('*', max_len + 2);
  printf("\n");
}

int
main(int argc, char** argv) {
  if (argc <= 1)
    return (0);
  print_frame(argv[1]);
  return (main(argc - 1, argv + 1));
}
