ARCHS = arm64 arm64e
TARGET = iphone:clang::11.0

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libstylepicker

libstylepicker_FILES = $(wildcard *.m)
libstylepicker_PRIVATE_FRAMEWORKS = Preferences
libstylepicker_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/library.mk

setup::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	@make
	@echo "Copying library and headers..."
	@cp $(THEOS_OBJ_DIR)/libstylepicker.dylib $(THEOS)/lib/libstylepicker.dylib
	@mkdir $(THEOS)/include/libstylepicker/
	@cp StylePickerTableViewCell.h $(THEOS)/include/libstylepicker/StylePickerTableViewCell.h
	@echo "Done."