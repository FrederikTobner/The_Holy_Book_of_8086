# The Holy Book of 8086

Programs written for the 8086 microprocessor in assembly language using nasm. The project is based on the book Programming boot sector games by Oscar Toledo G.
More information about the 8086 architecture can be found at the [wiki](https://github.com/FrederikTobner/The_Holy_Book_of_8086/wiki).

## Setup

Install [NASM](https://nasm.us/), [CMake](https://cmake.org/), [Ninja](https://ninja-build.org/) and [DOS-BOX](https://www.dosbox.com/).

### Building

Configure and build all programs (works on Windows, Linux and macOS):

```
cmake --preset ninja
cmake --build --preset ninja
```

The assembled `.com`/`.lst` files are written to `build/bin`. A single program can be built on its own, e.g. `cmake --build --preset ninja --target fizzbuzz`.

### Moving the programs to a DOSBox folder

The `move` target copies every assembled `.com` file into `DOSBOX_MOUNT_DIR` (defaults to `build/dosbox`):

```
cmake --build --preset ninja --target move
```

Set a custom destination by configuring with `-DDOSBOX_MOUNT_DIR=<folder>`.

### Executing a program

Add the following lines to your doxbox.conf file

```
MOUNT C <ExecutableFolder>
C:
```
