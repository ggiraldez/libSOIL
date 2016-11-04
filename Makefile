MAKE = make
CC = gcc
INSTALL_FILE = install -m 644
INSTALL_DIR = install -d
LN = ln -s
RM = rm -fv
CFLAGS += -c -O2 -Wall -fPIC
LDFLAGS += -framework OpenGL -framework CoreFoundation

CFILES = image_DXT.c image_helper.c SOIL.c stb_image_aug.c stb_image_write.c
OFILES = $(CFILES:.c=.o)
LIBNAME = libSOIL

HFILES = SOIL.h image_DXT.h image_helper.h \
  stbi_DDS_aug.h stbi_DDS_aug_c.h stb_image_aug.h stb_image_write.h
INCLUDEDIR = /usr/local/include/SOIL
LIBDIR = /usr/local/lib

all: $(OFILES) lib

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

lib: $(OFILES)
	# create static library
	$(CC) -shared $(OFILES) -o $(LIBNAME).so

install:
	$(INSTALL_DIR) $(INCLUDEDIR)
	$(INSTALL_FILE) $(HFILES) $(INCLUDEDIR)
	$(INSTALL_DIR) $(LIBDIR)
	$(INSTALL_FILE) $(AFILE) $(LIBDIR)

clean:
	$(RM) *.o
	$(RM) *~
	$(RM) $(LIBNAME).so

.PHONY: all lib clean
