# Boot sector games

Games written for 8086/8088 in assembly language.

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

## Resources

[Setup and Installation of DOS-BOX](https://www.dosbox.com/wiki/Basic_Setup_and_Installation_of_DosBox)
