.PHONY: clean

PREFIX := /usr/local
SRC_MACROS := $(shell find src/ -type f)
DST_MACROS := $(patsubst src/%, $(DESTDIR)$(PREFIX)/%, $(SRC_MACROS))

install: $(DST_MACROS)

$(DESTDIR)$(PREFIX)/%: src/%
	install -m644 -D $< $@


NOW := $(shell date +%Y%m%d)
P := apache2-macros-$(NOW)
DISTFILE := $(P).tar.xz
DISTDIR := dist/$(P)
dist: $(DISTFILE)

$(DISTFILE): LICENSE makefile $(SRC_MACROS)
	mkdir -p $(DISTDIR)
	cp -a LICENSE makefile src $(DISTDIR)
	tar -C dist/ -cJf $(DISTFILE) $(P)

clean:
	rm -rf dist
	rm -rf $(DISTFILE)
