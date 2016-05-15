VERSION = 0.3

OBJDIR = .obj
hide = @

SRCS = \
	src/main.c \
	src/error.c \
	src/mmc.c \
	src/parser.c \
	src/vfs.c \
	src/vfs_mem.c \
	src/vfs_host.c \
	src/vfs_sd.c \
	src/dump.c \
	src/xmodem.c \
	src/cli.c \
	src/misc.c \
	src/utils.c \
	src/fscmds.c \
	src/fatfs/ff.c \
	src/fatfs/option/syscall.c \
	src/fatfs/option/unicode.c

CFLAGS = \
	-DVERSION=\"$(VERSION)\" \
	-Isrc/fatfs

all: piface.bin

clean::
	@echo CLEAN

depends :=
define build-piface
$(eval objs := $(patsubst %.c,$(OBJDIR)/$(variant)/%.o,$(SRCS)))
$(eval depends += $(patsubst %.c,$(OBJDIR)/$(variant)/%.d,$(SRCS)))

$(OBJDIR)/$(variant)/%.o: %.c
	@echo CC $(variant) $$@
	@mkdir -p $$(dir $$@)
	$(hide) $(cc) $(CFLAGS) $(cflags) -MM -MQ $$@ -o $$(patsubst %.o,%.d,$$@) $$^
	$(hide) $(cc) $(CFLAGS) $(cflags) $$< -c -o $$@

$(variant): $(objs)
	@echo LINK $(variant) $$@
	@mkdir -p $$(dir $$@)
	$(hide) $(link) -o $$@ $$^

clean::
	$(hide) rm -f $(objs) $(variant)
endef

variant := piface.bin
cflags := -DTARGET_PI
cc := ack -mrpi -O
link := $(cc) -.c -t
$(eval $(build-piface))

variant := piface-gcc.elf
cflags := -DTARGET_PI
cc := vc4-elf-gcc -Os -save-temps
link := $(cc) -T vc4-sram.ld
$(eval $(build-piface))

piface-gcc.bin: piface-gcc.elf
	vc4-elf-objcopy -O binary piface-gcc.elf piface-gcc.bin

variant := piface
cflags := -DTARGET_TESTBED
cc := gcc -g -Wall
link := $(cc)
$(eval $(build-piface))

-include $(depends)
clean::
	$(hide) rm -f $(depends)

