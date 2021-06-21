# System Crafters Guix Installer

This repository runs automated CI builds to produce a
[GNU Guix](https://guix.gnu.org) installation image using the
**full Linux kernel** from the
[Nonguix channel](https://gitlab.com/nonguix/nonguix). If you are using a
modern laptop or hardware that is incompatible with the **Linux Libre kernel**,
this installer image is for you!

You can take a look at the [image configuration](installer.scm) and the
[build workflow](.github/workflows/build.yaml) to be sure that we aren't adding
anything malicious to these builds!

A new ISO is produced at least once a week, sometimes more often if we're
making improvements to the configuration.

Special thanks to [@anntnzrb](https://github.com/anntnzrb) for providing the
starting point for the CI configuration!

## License

The code in this repository is licensed under the
[GNU General Public License v3](LICENSE.txt).
