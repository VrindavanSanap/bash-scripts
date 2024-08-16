#!/bin/bash

# Created by Vrindavan Sanap
# cleanup.sh 
# made for bash shell


echo "Cleaning up the Downloads folder! Don't worry, I've got this!"

for file_type in pdf jpeg jpg mp3 mp4 png wav; do
    if mv *.$file_type ${file_type}s 2>/dev/null; then
        echo "Woohoo! $file_type files moved successfully!"
    else
        echo "Hmm... it seems like there are no $file_type files to move."
    fi
done

echo "Downloads folder cleaned up! You're welcome, human!"

