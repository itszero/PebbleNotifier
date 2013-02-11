export ARCHS=armv7 armv7s
export TARGET=iphone:latest:4.3

include theos/makefiles/common.mk

TWEAK_NAME = PebbleNotifier
PebbleNotifier_FILES = Tweak.xm
PebbleNotifier_FRAMEWORKS = UIKit
PebbleNotifier_PRIVATE_FRAMEWORKS = AppSupport

include $(THEOS_MAKE_PATH)/tweak.mk
