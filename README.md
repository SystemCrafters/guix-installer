# System Crafters Guix Installer

This repository runs _automated CI builds_ to produce a
[GNU Guix](https://guix.gnu.org) installation image using the
**full Linux kernel** from the
[Nonguix channel](https://gitlab.com/nonguix/nonguix). If you are using a
modern laptop or hardware that is incompatible with the **Linux Libre kernel**,
this installer image is for you!

You may take a look at the [image configuration](./guix/installer.scm) and the
[build workflow](./.github/workflows/build.yaml) to be sure that we aren't adding
anything malicious to these builds!

**A new `.iso` image is produced at least once a week, sometimes more often if
we're making improvements to the configuration.**

## Table of Contents
- [System Crafters Guix Installer](#system-crafters-guix-installer)
  - [Instructions](#instructions)
  - [Attributions](#attributions)
  - [License](#license)

## Instructions

1. Download a recently built `.iso` from this repo's
   [release page](https://github.com/SystemCrafters/guix-installer/releases)
2. Flash the `.iso` file into a USB stick with at least `3Gb`.

### Flashing the ISO

As stated in _step #2_ at [Instructions](#instructions), you will need to flash
the `.iso` file into a USB stick.

**[*]nix**:

You should only need the `dd` utility (_coreutils_):

- `dd status=progress if=guix-installerYYYYMMDDHHMM.iso of=/dev/foo`
  - where `guix-installerYYYYMMDDHHMM.iso` is the name of the downloaded `.iso`
    image and `foo` the name of the targeted device to flash the image.

For the sake of providing an example, here's the full command:

```sh
dd status=progress if=guix-installer-202106150234.iso of=/dev/sdb
```

> NOTE #1: You can list your devices with `lsblk`.

> NOTE #2: If `dd` won't work, refer to the **Windows** section.

**Windows**:

- [balenaEtcher](https://www.balena.io/etcher) is a great **cross-platform**
  _FOSS_ utility for flashing _GNU/Linux_ images.
- If the above doesn't work, you might give [Rufus](https://rufus.ie/en_US/) a
  look.

## Attributions

- [@anntnzrb](https://github.com/anntnzrb) for providing the starting point for
  the _CI_ configuration.
- [@daviwil](https://github.com/daviwil) for releasing the finished _CI_
  configuration and getting everything up and running.
- The [System Crafters](https://systemcrafters.cc)' community.

## License

The code in this repository is licensed under the
[GNU General Public License v3](./LICENSE.txt).
