export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:11.2

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libstylepicker
BUNDLE_NAME = stylepicker
stylepicker_INSTALL_PATH = /Library/PreferenceBundles

libstylepicker_FILES = $(wildcard *.m)
libstylepicker_PRIVATE_FRAMEWORKS = Preferences
libstylepicker_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/bundle.mk

setup::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	@make
	@echo "Copying library and headers..."
	@cp $(THEOS_OBJ_DIR)/libstylepicker.dylib $(THEOS)/lib/libstylepicker.dylib
	@mkdir $(THEOS)/include/libstylepicker/
	@cp StylePickerTableViewCell.h $(THEOS)/include/libstylepicker/StylePickerTableViewCell.h
	@echo "Done."