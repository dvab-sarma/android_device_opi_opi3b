#
# Copyright (C) 2021-2023 KonstaKANG
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/aosp_opi3b.mk \
    $(LOCAL_DIR)/aosp_opi3b_car.mk \
    $(LOCAL_DIR)/aosp_opi3b_tv.mk

COMMON_LUNCH_CHOICES := \
    aosp_opi3b-trunk_staging-userdebug \
    aosp_opi3b_car-trunk_staging-userdebug \
    aosp_opi3b_tv-trunk_staging-userdebug
