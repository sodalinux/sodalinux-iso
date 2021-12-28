#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

# nsswitch.conf settings
# * Avahi : add 'mdns_minimal'
# * Winbind : add 'wins'
sed -i '/^hosts:/ {
        s/\(resolve\)/mdns_minimal \[NOTFOUND=return\] \1/
        s/\(dns\)$/\1 wins/ }' /etc/nsswitch.conf

# Force wayland session type (related to Nvidia proprietary driver)
sed -i 's|^\(Exec=\).*|\1env XDG_SESSION_TYPE=wayland /usr/bin/gnome-session|' /usr/share/xsessions/gnome.desktop

# Remove duplicate from lightdm sessions type list
mv /usr/share/wayland-sessions/gnome.desktop{,.duplicate}

# missing link pointing to default vncviewer
ln -s /usr/bin/gvncviewer /usr/local/bin/vncviewer

# Enable service when available
{ [[ -e /usr/lib/systemd/system/acpid.service                ]] && systemctl enable acpid.service;
  [[ -e /usr/lib/systemd/system/avahi-dnsconfd.service       ]] && systemctl enable avahi-dnsconfd.service;
  [[ -e /usr/lib/systemd/system/bluetooth.service            ]] && systemctl enable bluetooth.service;
  [[ -e /usr/lib/systemd/system/NetworkManager.service       ]] && systemctl enable NetworkManager.service;
  [[ -e /usr/lib/systemd/system/nmb.service                  ]] && systemctl enable nmb.service;
  [[ -e /usr/lib/systemd/system/cups.service                 ]] && systemctl enable cups.service;
  [[ -e /usr/lib/systemd/system/smb.service                  ]] && systemctl enable smb.service;
  [[ -e /usr/lib/systemd/system/systemd-timesyncd.service    ]] && systemctl enable systemd-timesyncd.service;
  [[ -e /usr/lib/systemd/system/winbind.service              ]] && systemctl enable winbind.service;
} > /dev/null 2>&1

# Set gdm.service to be the default display manager
ln -s /usr/lib/systemd/system/gdm.service /etc/systemd/system/display-manager.service

# Set default target so Arch doesnt shit itself when it boots using BIOS mode
systemctl set-default graphical.target

# Set default background because why not (we have to get a little hacky for this one)
cp -f /usr/share/backgrounds/default.png /usr/share/backgrounds/gnome/adwaita-day.png
cp -f /usr/share/backgrounds/default.png /usr/share/backgrounds/gnome/adwaita-morning.png
cp -f /usr/share/backgrounds/default.png /usr/share/backgrounds/gnome/adwaita-night.png
rm /usr/share/backgrounds/default.png

# change file permissions for neofetch because idk
chmod +x /usr/bin/neofetch

# also change file permissions for post install script

chmod +x /usr/local/bin/post-install

# Add live user
# * groups member
# * user without password
# * sudo no password settings
useradd -m -G 'wheel' -s /bin/zsh live
sed -i 's/^\(live:\)!:/\1:/' /etc/shadow
sed -i 's/^#\s\(%wheel\s.*NOPASSWD\)/\1/' /etc/sudoers

# edit lsb-release to reflect os name on things like neofetch
sed -i 's/DISTRIB_DESCRIPTION="Arch Linux"/DISTRIB_DESCRIPTION="Soda Linux"/g' /etc/lsb-release

# edit pacman.conf to enable some nice QoL features
sed -i /etc/pacman.conf \
        -e '/^#Color/a ILoveCandy' \
        -e 's|^#Color|Color|' \
        -e 's|^#VerbosePkgLists|VerbosePkgLists|' \
        -e 's|^#ParallelDownloads|ParallelDownloads|' \

# enable multilib repo in pacman because why not
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Create autologin group
# add live to autologin group
groupadd -r autologin
gpasswd -a live autologin

# disable systemd-networkd.service
# we have NetworkManager for managing network interfaces
[[ -e /etc/systemd/system/multi-user.target.wants/systemd-networkd.service ]] && rm /etc/systemd/system/multi-user.target.wants/systemd-networkd.service
[[ -e /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service ]] && rm /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service
[[ -e /etc/systemd/system/sockets.target.wants/systemd-networkd.socket ]] && rm /etc/systemd/system/sockets.target.wants/systemd-networkd.socket
