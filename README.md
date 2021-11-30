# sodalinux-iso

The official ISO profile for Soda Linux. This profile is intended to be used with [archuseriso.](https://github.com/laurent85v/archuseriso) We will be replacing the tool we use soon with the official archiso method


# FAQ

- How do I use this?

You are required to have Arch Linux or an Arch-based derivative installed in order to build this ISO file.

First, install [archuseriso](https://github.com/laurent85v/archuseriso) onto your system.

After [archuseriso](https://github.com/laurent85v/archuseriso) is installed, clone this repo using:

`git clone https://github.com/sodalinux/sodalinux-iso`

After you cloned the repo, do `sudo aui-mkiso <directory>/sodalinux-iso` and wait a few moments.

The ISO should be located in a folder called `out` which contains both the ISO and a checksum file for the ISO. You should now have a full ISO built and ready to install.

- What if I want to help make improvments?

We are more than happy that you want to pitch in and help us make our ISO better!

Before you clone this repo and start making changes, you need to make yourself familiar with:

> - **The Arch Linux ISO building process**

> - **How the Arch Linux package manager, pacman, works.**

> - **How the Arch Linux boot process works**

> - **How SquashFS works**

> - **Other processes related to building an ISO using mkarchiso**

If you have all of those things down, and you are confident that you know how everything works, feel free to submit a pull request highlighting your changes and we'll take a look before we add it to the repo.






