cmd_/home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/linux/can/.install := perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/linux/can /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/linux/can arm bcm.h error.h gw.h netlink.h raw.h; perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/linux/can /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/linux/can arm ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/linux/can/$$F; done; touch /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/linux/can/.install
