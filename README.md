udev-media-automount
====================

Auto mount removable media devices by means of udev rules.

This is intended for simple systems that don't want or can't run the udisks2 daemon (which is designed for GNOME/KDE desktop environments and at the time of this writting is frustrating to set up from a bare commandline).

This combines the previous udev rules I was using in my xdg_config repository with some structure and ideas taken from tylorchu's usb-automount.

Every device that is inserted and isn't already configured in `/etc/fstab` will be mounted by media-automount. This includes not only usb devices but also card readers and other media with a `/dev/sd*` device.

If there are devices you don't want to automount neither at boot nor with media-automount, you can add them in /etc/fstab with the option 'noauto'.

The mount options might differ to the filesystem type for the device plugged in. E.g. vFAT and NTFS devices will be mounted with the "flush" option to try to prevent damage on accidental removals of the device with unclean umounts. Also whenever ntfs-3g is available, it will be used to mount ntfs devices.

The mount directory will appear in /media/ under a name with pattern: `<LABEL OF THE FS>.<FS TYPE>`
(if duplicate, `_<NUMBER>` will be appended).

Due to changes in udev (long running processes are killed), it's necessary to use systemd for spawning a mounting service.

To check the logs produced by the script, run `journalctl -t media-automount`, add `-b` for current boot.

Installation
------------

For Archlinux, the [`udev-media-automount` AUR package](https://aur.archlinux.org/packages/udev-media-automount) is offered.

For other systems, you may download the content of the repository from
https://github.com/Ferk/udev-media-automount/archive/refs/heads/master.zip

You can then install it using the following instructions

```
unzip master.zip
cd udev-media-automount-master
sudo make install
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Configuration
-------------

The folder `/etc/media-automount.d` can be used to set custom mount options for specific device types.

If a file with filename matching a filesystem type (eg. `vfat`, `nfts`, `etc`) is found, it'll be loaded when a device using the given filesystem is to be mounted. This can be used to change the parameters provided to `mount`.

An example below for `/etc/media-automount.d/ntfs`:

```
# Mount options to use for auto-mounting NTFS drives
AUTOMOUNT_OPTS='errors=remount-ro,relatime,utf8,user,flush'

# Always use NTFS-3G to automount NTFS filesystems
AUTOMOUNT_TYPE="ntfs-3g"
```

Note that these files are sourced as shell scripts, so it's possible to include logic in them in case you want to conditionally apply some configuration.
