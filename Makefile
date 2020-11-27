.PHONY: install
install:
	install -D media-automount $(DESTDIR)/bin/media-automount
	install -D umount_dmenu $(DESTDIR)/bin/umount_dmenu
	install -d $(DESTDIR)/etc/media-automount.d
	install -Dm644 media-automount.d/* $(DESTDIR)/etc/media-automount.d/
	install -Dm644 media-automount.rules $(DESTDIR)/lib/udev/rules.d/99-media-automount.rules
	install -Dm644 media-automount@.service $(DESTDIR)/lib/systemd/system/media-automount@.service

