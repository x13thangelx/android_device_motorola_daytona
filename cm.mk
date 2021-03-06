## Specify phone tech before including full_phone
#$(call inherit-product, vendor/cm/config/cdma.mk)

## Release name
PRODUCT_RELEASE_NAME := DroidX2
 
## Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)
 
## Inherit device configuration
$(call inherit-product, device/motorola/daytona/daytona.mk)
 
PRODUCT_NAME := gummy_daytona
 
## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := daytona

## Device fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_BRAND=MOTO PRODUCT_NAME=daytona BUILD_ID=4.5.1A-DTN-130 BUILD_PRODUCT=daytona BUILD_FINGERPRINT=verizon/daytona/daytona:2.3.4/4.5.1A-DTN-150-30/0:user/release-keys PRIVATE_BUILD_DESC="daytona-user 2.3.4 4.5.1A-DTN-150-30 0 release-keys"
