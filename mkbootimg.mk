#
# Copyright (C) 2021-2022 KonstaKANG
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/opi/opi3b
KERNEL_PATH := device/opi/opi3b-kernel
SIZE := $(100*1024)
BOOT:= $(PRODUCT_OUT)/boot.img

OPI_BOOT_OUT := $(PRODUCT_OUT)/opiboot

$(OPI_BOOT_OUT): $(INSTALLED_RAMDISK_TARGET)
	mkdir -p $(OPI_BOOT_OUT)
	cp $(KERNEL_PATH)/Image $(OPI_BOOT_OUT)
	cp $(KERNEL_PATH)/rk3566-orangepi-3b-v2.1.dtb $(OPI_BOOT_OUT)
	cp $(KERNEL_PATH)/boot.scr $(OPI_BOOT_OUT)
	cp $(KERNEL_PATH)/uRamdisk $(OPI_BOOT_OUT)
	cp $(PRODUCT_OUT)/ramdisk.img $(OPI_BOOT_OUT)

$(INSTALLED_BOOTIMAGE_TARGET): $(OPI_BOOT_OUT)
	$(call pretty,"Target boot image: $@")

	dd if=/dev/zero of=$@ bs=1M count=128
	mkfs.fat -F 32 -n "boot" $@
	mcopy -s -i $@ $(OPI_BOOT_OUT)/* ::
# $(INSTALLED_BOOTIMAGE_TARGET): $(OPI_BOOT_OUT)
# 	$(call pretty,"Target boot image: $@")

# 	# Determine size in bytes, add 10 MiB padding, convert to 512-byte blocks
# 	BOOT_SIZE_BYTES=`du -s -k $(OPI_BOOT_OUT) | awk '{ print $$1 * 1024 }'`; \
# 	PADDED_BYTES=`expr $$BOOT_SIZE_BYTES + 10485760`; \
# 	BLOCKS=`expr $$PADDED_BYTES / 512`; \
# 	echo "Creating boot image with $$BLOCKS blocks..."; \
# 	dd if=/dev/zero of=$@ bs=512 count=$$BLOCKS; \
# 	mkfs.fat -F 32 -n "boot" $@; \
# 	mcopy -s -i $@ $(OPI_BOOT_OUT)/* ::
#mcopy -i $@ -s -n -b -m -D o $(OPI_BOOT_OUT)/* ::
# 	rm -rf $(BOOT)
# 	mkfs.vfat -F 32 -n "boot" -S 512 -C $@ $(SIZE)
