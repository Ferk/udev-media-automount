install:
	install -D media-automount.rules $(DESTDIR)/lib/udev/rules.d/99-media-automount.rules
	install -D umount_dmenu $(DESTDIR)/bin/umount_dmenu
	install -D media-automount $(DESTDIR)/bin/media-automount
	install -D media-automount@.service $(DESTDIR)/lib/systemd/system/media-automount@.service

