#!/bin/sh

insmod /lib/modules/$(uname -r)/kernel/drivers/mfd/rtsx_pci.ko
insmod /lib/modules/$(uname -r)/kernel/drivers/mmc/host/rtsx_pci_sdmmc.ko
