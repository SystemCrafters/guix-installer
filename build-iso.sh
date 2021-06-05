#!/bin/sh

# Write out the current channels to be included with the image
guix describe -f channels > channels.scm

# Build the image and copy it to the current directory
image=$(guix system image -t iso9660 installer.scm)
echo "Built image: $image"
cp $image ./guix-installer.iso
