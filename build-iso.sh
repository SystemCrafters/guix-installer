#!/bin/sh

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------

die() {
    # **
    # Prints a message to stderr & exits script with non-successful code "1"
    # *

    printf '%s\n' "$@" >&2
    exit 1
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

# Write out the channels file so it can be included
guix time-machine -C './guix/base-channels.scm' -- \
     describe -f channels > './guix/channels.scm'

# Build the image
printf 'Attempting to build the image...\n\n'
image=$(guix time-machine -C './guix/channels.scm' -- system image -t iso9660 './guix/installer.scm') \
    || die 'Could not create image.'

release_tag=$(date +"%Y%m%d%H%M")
cp "${image}" "./guix-installer-${release_tag}.iso" ||
    die 'An error occurred while copying.'

printf 'Image was succesfully built: %s\n' "${image}"

# cleanup
unset -f die
unset -v image release_tag
