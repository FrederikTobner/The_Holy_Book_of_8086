# The Holy Book of 8086

Programs written for the 8086 architecture in assembly language, that could be located in the boot-sector of an IBM-compatible environment.
The boot sector can hold up to 510 bytes. The project is based on the book Programming boot sector games by Oscar Toledo G.
More information about the 8086 architecture can be found at the [wiki](https://github.com/FrederikTobner/The_Holy_Book_of_8086/wiki)

## Setup

Install NASM, and DOS-BOX.

### Building

Builds the exectable

```
nasm -f bin <Assemblyfile> -o <Outputfile>
```

### Executing a program

Add the following lines to your doxbox.conf file

```
MOUNT C <ExecutableFolder>
C:
```
