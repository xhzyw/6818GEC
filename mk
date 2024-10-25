#!/bin/bash
#
# Description	: Android Build Script.
# Authors		: jianjun jiang - jerryjianjun@gmail.com
# Version		: 2.00
# Notes			: None
#

#
# JAVA PATH
#
export PATH=/usr/lib/jvm/java-7-oracle/bin:$PATH

#
# Some Directories
#
BS_DIR_TOP=$(cd `dirname $0` ; pwd)
BS_DIR_RELEASE=${BS_DIR_TOP}/out/release
BS_DIR_TARGET=${BS_DIR_TOP}/out/target/product/GEC6818/
BS_DIR_UBOOT=${BS_DIR_TOP}/GEC6818uboot
BS_DIR_KERNEL=${BS_DIR_TOP}/kernel


#
# Cross Toolchain Path
#
#BS_CROSS_TOOLCHAIN_BOOTLOADER=${BS_DIR_TOP}/prebuilts/gcc/linux-x64/local/arm/5.4.0/usr/bin/arm-linux-
#BS_CROSS_TOOLCHAIN_KERNEL=${BS_DIR_TOP}/prebuilts/gcc/linux-x64/local/arm/5.4.0/usr/bin/arm-linux-

BS_CROSS_TOOLCHAIN_BOOTLOADER=${BS_DIR_TOP}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-
BS_CROSS_TOOLCHAIN_KERNEL=${BS_DIR_TOP}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-

#
# Target Config
#
BS_CONFIG_BOOTLOADER_UBOOT=GEC6818_config
BS_CONFIG_KERNEL=GEC6818_defconfig
BS_CONFIT_BUILDROOT=GEC6818_defconfig

setup_environment()
{
	LANG=C
	cd ${BS_DIR_TOP};
	mkdir -p out/host/linux-x86/bin || return 1;
	mkdir -p ${BS_DIR_TARGET}/boot;

	[ -f "${BS_DIR_TOP}/out/host/linux-x86/bin/mkuserimg.sh" ] ||{ echo "tar generate boot.img tools"; tar xvf tools/generate_boot.tar.gz -C ${BS_DIR_TOP}/out/host/linux-x86/bin;}
	#[ -f "${BS_DIR_TARGET}/boot/root.img.gz" ] ||{ echo "tar boot.tar.gz"; tar xvf tools/boot.tar.gz -C ${BS_DIR_TARGET};}

	PATH=${BS_DIR_TOP}/out/host/linux-x86/bin:$PATH;

	mkdir -p ${BS_DIR_RELEASE} || return 1
}

build_bootloader_uboot()
{
	# Compiler uboot
	cd ${BS_DIR_UBOOT} || return 1
	make distclean CROSS_COMPILE=${BS_CROSS_TOOLCHAIN_BOOTLOADER} || return 1
	#cp ${BS_DIR_UBOOT}/board/s5p6818/GEC6818/GEC6818-lcd.mk ${BS_DIR_UBOOT}/board/s5p6818/GEC6818/fastboot_lcd.o
	#cp ${BS_DIR_UBOOT}/arch/arm/cpu/slsiap/devices/GEC6818-pmic.mk ${BS_DIR_UBOOT}/arch/arm/cpu/slsiap/devices/axp228_mfd.o
	cp net/x6818-eth.mk net/eth.o
	make ${BS_CONFIG_BOOTLOADER_UBOOT} CROSS_COMPILE=${BS_CROSS_TOOLCHAIN_BOOTLOADER} || return 1
	make -j${threads} CROSS_COMPILE=${BS_CROSS_TOOLCHAIN_BOOTLOADER} || return 1

	# Copy bootloader to release directory
	cp -v ${BS_DIR_UBOOT}/GECuboot.bin ${BS_DIR_RELEASE}
	cp -v ${BS_DIR_UBOOT}/readme.txt ${BS_DIR_RELEASE}
	cp -v ${BS_DIR_UBOOT}/env.txt ${BS_DIR_RELEASE}
	cp -v ${BS_DIR_UBOOT}/GEC6818-sdmmc.sh ${BS_DIR_RELEASE}

	echo "^_^ uboot path: ${BS_DIR_RELEASE}/GECuboot.bin"
	return 0
}

build_kernel()
{
	export PATH=${BS_DIR_UBOOT}/tools:$PATH 
	# Compiler kernel
	#cd ${BS_DIR_KERNEL} || return 1
	#make ${BS_CONFIG_KERNEL} ARCH=arm CROSS_COMPILE=${BS_CROSS_TOOLCHAIN_KERNEL} || return 1
	#make -j${threads} ARCH=arm CROSS_COMPILE=${BS_CROSS_TOOLCHAIN_KERNEL} || return 1
	#make -j${threads} ARCH=arm CROSS_COMPILE=${BS_CROSS_TOOLCHAIN_KERNEL} uImage || return 1

	# Copy uImage to release directory
	#cp -v ${BS_DIR_KERNEL}/arch/arm/boot/uImage ${BS_DIR_RELEASE}

	#echo "^_^ kernel path: ${BS_DIR_RELEASE}/uImage"

	# generate boot.img
	cd ${BS_DIR_TOP} || return 1
	echo 'boot.img ->' ${BS_DIR_RELEASE}
	# Make boot.img with ext4 format, 64MB
	cp -v ${BS_DIR_KERNEL}/arch/arm/boot/uImage ${BS_DIR_TARGET}/boot
	mkuserimg.sh -s ${BS_DIR_TARGET}/boot ${BS_DIR_TARGET}/boot.img ext4 boot 67108864

	cp -av ${BS_DIR_TARGET}/boot.img ${BS_DIR_RELEASE} || return 1;
	return 0
}

threads=4
uboot=no
kernel=no

if [ -z $1 ]; then
	uboot=yes
	kernel=yes
fi

while [ "$1" ]; do
    case "$1" in
	-j=*)
		x=$1
		threads=${x#-j=}
		;;
	-u|--uboot)
		uboot=yes
	    ;;
	-k|--kernel)
	    kernel=yes
	    ;;
	-a|--all)
		uboot=yes
		kernel=yes
	    ;;
	-h|--help)
	    cat >&2 <<EOF
Usage: build.sh [OPTION]
Build script for compile the source of telechips project.

  -j=n                 using n threads when building source project (example: -j=16)
  -u, --uboot          build bootloader uboot from source
  -k, --kernel         build kernel from source
  -a, --all            build all, include anything
  -h, --help           display this help and exit
EOF
	    exit 0
	    ;;
	*)
	    echo "build.sh: Unrecognised option $1" >&2
	    exit 1
	    ;;
    esac
    shift
done

setup_environment || exit 1

if [ "${uboot}" = yes ]; then
	build_bootloader_uboot || exit 1
fi

if [ "${kernel}" = yes ]; then
	build_kernel || exit 1
fi

exit 0
