# Boot sector games

Programs written for 8086/8088 in assembly language, that could be located in the boot-sector of an IBM-compatible environment.
The boot sector can hold up to 510 bytes. The project is based on the book Programming boot sector games by Oscar Toledo G.

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

## 8086

### Insruction set

#### Arithmetic instructions

| Opcode | Usage    | Description                                                    |
|--------|----------|----------------------------------------------------------------|
| AAD    | AAD      | Adjust accumulator after division                              |
| ADD    | ADD A, B | Computes A + B and stores the result in A                      |
| ADC    | ADC A, B | Computes A + B + the prevoius carry and stores the result in A |


#### Logical instructions

### Registers

### Interrupts

### Memory segments

The memory of computer is divided into four segments:

* Code segment (CS)
* Data segment (DS)
* Extra segment (ES)
* Stack segment (SS)

For each of these segments a special purpose register, that stores the base address (address of the start of the segment) of the segment, is provided.

### Flags

| Name                      | Description                                                                                                                   |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| CF (Carry Flag)           | Signals an overflow after a arithmetic operation                                                                              |
| SF (Sign Flag)            | Set if the result of an arithmetic operation is negative                                                                      |
| ZF (Zero Flag)            | Signals an overflow after a arithmetic operation                                                                              |
| AC (Auxiliary Carry flag) | Signals an overflow after a arithmetic operation                                                                              |
| PF (Parity flag)          | Signals an overflow after a arithmetic operation                                                                              |
| O (Overflow flag)         | This flag will be set if the result of a signed operation is too large to fit in the number of bits available to represent it |

#### Control Flags

| Name                      | Description                                                                                                                   |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| D (Directional Flag)      | Signals an overflow after a arithmetic operation                                                                              |
| I (Interrupt Flag)        | Set if the result of an arithmetic operation is negative                                                                      |
| T (Trap Flag)             | Used for on-chip-debugging. Setting the flag puts the 8086 into single step mode                                              |


## Resources

### English

[Setup and Installation of DOS-BOX](https://www.dosbox.com/wiki/Basic_Setup_and_Installation_of_DosBox)

### German

[8086/8088 Reference](https://www.i8086.de/)
[8086 Handbook (German)](https://www.pearson.ch/download/media/9783827320148_SP.pdf)
