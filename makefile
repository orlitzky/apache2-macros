.PHONY: clean

PREFIX := /usr/local
SRC_FILES := $(shell find src/ -type f)
DST_FILES := $(patsubst src/%, $(DESTDIR)$(PREFIX)/%, $(SRC_FILES))

install: $(DST_FILES)

$(DESTDIR)$(PREFIX)/%: src/%
	install -m644 -D $< $@


NOW := $(shell date +%Y%m%d)
P := apache2-macros-$(NOW)
DISTFILE := $(P).tar.xz
DISTDIR := dist/$(P)
dist: $(DISTFILE)

$(DISTFILE): LICENSE makefile $(SRC_FILES)
	mkdir -p $(DISTDIR)
	cp -a LICENSE makefile src $(DISTDIR)
	tar -C dist/ -cJf $(DISTFILE) $(P)

clean:
	rm -rf dist
	rm -rf $(DISTFILE)
