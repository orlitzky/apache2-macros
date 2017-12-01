.PHONY: clean publish

PREFIX := /usr/local
LIBDIR := lib64
SRC_FILES := $(shell find src/ -type f)
DST_FILES := $(patsubst src/lib/%,\
               $(DESTDIR)$(PREFIX)/$(LIBDIR)/%,\
               $(SRC_FILES))

install: $(DST_FILES)

$(DESTDIR)$(PREFIX)/$(LIBDIR)/%: src/lib/%
	install -m644 -D $< $@

PN := apache2-macros
NOW := $(shell date +%Y%m%d)
P := $(PN)-$(NOW)
DISTFILE := $(P).tar.xz
DISTDIR := dist/$(P)
dist: $(DISTFILE)

$(DISTFILE): LICENSE makefile $(SRC_FILES)
	mkdir -p $(DISTDIR)
	cp -a LICENSE makefile src $(DISTDIR)
	tar -C dist/ -cJf $(DISTFILE) $(P)


publish: $(DISTFILE)
	scp $(DISTFILE) http2.viabit.com:/var/www/viabit.com/www/public/sites/default/files/code/releases/

clean:
	rm -rf dist
	rm -rf $(PN)-*.tar.xz
