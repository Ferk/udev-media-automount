udev-media-automount
====================

Auto mount removable media devices by means of udev rules.

This is intended for simple systems that don't want or can't run the udisks2 daemon (which is designed for GNOME/KDE desktop environments and at the time of this writting is frustrating to set up from a bare commandline).

This combines the previous udev rules I was using in my xdg_config repository with some structure and ideas taken from tylorchu's usb-automount.

Every device that is inserted and isn't already configured in /etc/fstab will be mounted by media-automount. This includes not only usb devices but also card readers and other media with a /dev/sd* device.

If there are devices you don't want to automount neither at boot nor with media-automount, you can add them in /etc/fstab with the option 'noauto'.

The mount options might differ to the filesystem type for the device plugged in. E.g. vFAT and NTFS devices will be mounted with the "flush" option to try to prevent damage on accidental removals of the device with unclean umounts. Also whenever ntfs-3g is available, it will be used to mount ntfs devices.

The mount directory will appear in /media/ under a name with pattern: "LABEL_OF_THE_FS.FS_TYPE"


Due to changes in udev (long running processes are killed), it's necessary to use systemd for spawning a mounting service.

The script will also use the 'logger' tool to write to the system log.
