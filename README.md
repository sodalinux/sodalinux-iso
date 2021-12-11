# sodalinux-iso

The official ISO profile for Soda Linux. This profile is intended to be used with [archiso.](https://github.com/archlinux/archiso) 


# FAQ

### How do I use this?

**IMPORTANT: You are required to have Arch Linux or an Arch-based derivative installed in order to build this ISO file.**

First, install [archiso](https://github.com/archlinux/archiso) onto your system.

```
sudo pacman -S archiso
```

After archiso is installed, clone this repo using:

```
git clone https://github.com/sodalinux/sodalinux-iso
```

After you cloned the repo, `cd` into the directory, and run `./build.sh` and wait a few moments.

A bunch of text will appear on screen for the remainder of the ISO building process. Don't freak out, this is just the script working it's magic.

If the ISO building process at anytime stops due to an error, please open up a issue in the repo.

If all goes well, the ISO should be located in a folder called `out` which contains the ISO file. You should now have a full ISO built and ready to install.

### What if I want to help make improvments?

We are more than happy that you want to pitch in and help us make our ISO better!

Before you clone this repo and start making changes, you need to make yourself familiar with:

> - **The Arch Linux ISO building process**

> - **How the Arch Linux package manager, pacman, works.**

> - **How the Arch Linux boot process works**

> - **How SquashFS works**

> - **Other processes related to building an ISO using mkarchiso**

If you have all of those things down, and you are confident that you know how everything works, feel free to submit a pull request highlighting your changes and we'll take a look before we add it to the repo.






