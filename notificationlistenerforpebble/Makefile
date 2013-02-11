export ARCHS=armv7 armv7s
export TARGET=iphone:latest:4.3

include theos/makefiles/common.mk

TWEAK_NAME = NotificationListenerForPebble
NotificationListenerForPebble_FILES = Tweak.xm
NotificationListenerForPebble_PRIVATE_FRAMEWORKS = AppSupport

include $(THEOS_MAKE_PATH)/tweak.mk
