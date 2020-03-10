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
	mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	cp .theos/obj/debug/libstylepicker.dylib $(THEOS)/lib
	mkdir -p $(THEOS_STAGING_DIR)/usr/include/libstylepicker
	cp StylePickerTableViewCell.h $(THEOS_STAGING_DIR)/usr/include/libstylepicker