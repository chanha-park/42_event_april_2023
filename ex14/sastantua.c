#include <stdlib.h>
#include <unistd.h>

int
calc_base(int size) {
  int floor;
  int width;
  int floor_step;

  floor = 1;
  width = 1;
  floor_step = 4;
  while (floor <= size) {
    width += 2 * (2 + floor);
    ++floor;
    width += floor_step;
    if (floor % 2 && floor < size)
      floor_step += 2;
  }
  width -= floor_step;
  return (width);
}

void
print_space(int space) {
  int pos;

  pos = 0;
  while (pos < space) {
    write(1, " ", 1);
    ++pos;
  }
}

void
print_line(int size, int floor, int width, int step) {
  int door;
  int pos;

  door = 1 + 2 * ((floor - 1) / 2);
  pos = 0;
  while (pos < width) {
    if (pos == 0)
      write(1, "/", 1);
    else if (pos == width - 1)
      write(1, "\\", 1);
    else {
      if (floor == size && pos >= (width - door) / 2 && pos < (width + door) / 2
          && 2 + floor - step <= door)
        if (door >= 5 && step == 2 + floor - door / 2 - 1
            && pos == (width + door) / 2 - 2)
          write(1, "$", 1);
        else
          write(1, "|", 1);
      else
        write(1, "*", 1);
    }
    ++pos;
  }
}

void
sastantua(int size) {
  int floor;
  int height;
  int step;
  int width;
  int base_size;

  if (size < 1)
    return;
  floor = 1;
  width = 1;
  while (floor <= size) {
    height = 2 + floor;
    step = 0;
    base_size = calc_base(size);
    while (step < height) {
      width += 2;
      print_space((base_size - width) / 2);
      print_line(size, floor, width, step);
      write(1, "\n", 1);
      ++step;
    }
    ++floor;
    width += 4 + 2 * ((floor - 2) / 2);
  }
}

int
main(int argc, char* argv[]) {
  if (argc == 2)
    sastantua(atoi(argv[1]));
  return 0;
}
