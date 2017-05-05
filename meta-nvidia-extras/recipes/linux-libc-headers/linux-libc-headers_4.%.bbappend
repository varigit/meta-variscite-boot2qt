# Copyright (c) 2015-2016, NVIDIA CORPORATION.  All rights reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms and conditions of the GNU General Public License,
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# KERN_DIR holds linux.tar.bz2
KERN_DIR := "${LNX_TOPDIR}_src/kernel"
# Kernel source is the kernel tarball in PDK
SRC_URI = "file://${KERN_DIR}/linux.tar.bz2"
PV = "4.4"

# Extracting linux.tar.bz2 creates directories
# <top>/vibrante-oss-src/kernel
S = "${WORKDIR}/vibrante-oss-src/kernel"

# Need to pass this to for oe_runmake explicitly for building outside kerneldir
EXTRA_OEMAKE += " -C ${S} O=${B}"

# Apply RT patches
require recipes-kernel/linux/apply-rt-patches.inc
