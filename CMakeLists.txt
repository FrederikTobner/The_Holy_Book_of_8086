cmake_minimum_required(VERSION 3.12)
project(TheHolyBookOf8086 NONE)

find_program(NASM_EXECUTABLE nasm REQUIRED)

set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)
set(LIB_DIR ${CMAKE_SOURCE_DIR}/lib)
set(LIBRARY_ASM ${LIB_DIR}/library.asm)
set(PROGRAM_OUTPUT_DIR ${CMAKE_BINARY_DIR}/bin)

# Directory the "move" target copies the assembled .com files into, e.g. a DOSBox mount folder.
set(DOSBOX_MOUNT_DIR "${CMAKE_BINARY_DIR}/dosbox" CACHE PATH "Destination folder for the 'move' target")

file(GLOB PROGRAM_SOURCES CONFIGURE_DEPENDS ${SRC_DIR}/*.asm)

set(ALL_PROGRAM_OUTPUTS "")
foreach(program_source ${PROGRAM_SOURCES})
    get_filename_component(program_name ${program_source} NAME_WE)
    set(com_file ${PROGRAM_OUTPUT_DIR}/${program_name}.com)
    set(lst_file ${PROGRAM_OUTPUT_DIR}/${program_name}.lst)

    add_custom_command(
        OUTPUT ${com_file}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${PROGRAM_OUTPUT_DIR}
        COMMAND ${NASM_EXECUTABLE} -f bin ${program_source} -l ${lst_file} -o ${com_file}
        DEPENDS ${program_source} ${LIBRARY_ASM}
        COMMENT "Assembling ${program_name}.asm"
        VERBATIM
    )
    add_custom_target(${program_name} DEPENDS ${com_file})

    list(APPEND ALL_PROGRAM_OUTPUTS ${com_file})
endforeach()

add_custom_target(programs ALL DEPENDS ${ALL_PROGRAM_OUTPUTS})

# Phony target copying every assembled .com file into DOSBOX_MOUNT_DIR, replacing MovePrograms.bat.
add_custom_target(move
    COMMAND ${CMAKE_COMMAND} -E make_directory ${DOSBOX_MOUNT_DIR}
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ALL_PROGRAM_OUTPUTS} ${DOSBOX_MOUNT_DIR}
    DEPENDS programs
    COMMENT "Copying assembled programs to ${DOSBOX_MOUNT_DIR}"
    VERBATIM
)
