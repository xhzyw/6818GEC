cmd_/home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/scsi/.install := perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/scsi /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/scsi arm scsi_bsg_fc.h scsi_netlink.h scsi_netlink_fc.h; perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/scsi /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/scsi arm ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/scsi/$$F; done; touch /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/scsi/.install
