cmd_/home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/video/.install := perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/video /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/video arm edid.h sisfb.h uvesafb.h; perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/video /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/video arm ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/video/$$F; done; touch /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/video/.install
