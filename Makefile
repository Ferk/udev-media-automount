install:
	install -D usb-automount.rules $(DESTDIR)/usr/lib/udev/rules.d/99-usb-automount.rules
	install -D umount_dmenu $(DESTDIR)/usr/bin/umount_dmenu
