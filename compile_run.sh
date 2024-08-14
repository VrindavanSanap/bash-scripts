#!/bin/bash

# Check if a file name was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: ./compile_run.sh <file_name>"
    exit 1
fi

# Extract the file name without extension and the file extension
file_name="${1%.*}"
extension="${1##*.}"

# Define a function to compile and run a file
compile_and_run() {
    local file_name="$1"
    local extension="$2"
    local compiler
    local output_file_name

    case "$extension" in
        "asm")
            compiler="nasm -f elf64"
            output_file_name="${file_name}.o"
            ;;
        "c")
            compiler="gcc"
            output_file_name="${file_name}"
            ;;
        *)
            echo "Unsupported file extension: $extension"
            return 1
            ;;
    esac

    # Compile the file
    if ! $compiler "${file_name}.${extension}" -o "${output_file_name}"; then
        echo "Compilation failed for ${file_name}.${extension}"
        return 1
    fi

    # Run the compiled file
    if [ "$extension" == "asm" ]; then
        # Link the object file for assembly
        if ! ld -o "${file_name}" "${output_file_name}"; then
            echo "Linking failed for ${file_name}.o"
            return 1
        fi
        # Remove the object file
        rm -rf "${output_file_name}"
        # Run the executable
        ./"${file_name}"
    else
        # Run the executable directly for C
        ./"${file_name}"
    fi

    echo $?
}

# Call the function for the given file
compile_and_run "$file_name" "$extension"
