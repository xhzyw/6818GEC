cmd_/home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/sound/.install := perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/sound /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/sound arm asequencer.h asound.h asound_fm.h emu10k1.h hdsp.h hdspm.h sb16_csp.h sfnt_info.h; perl scripts/headers_install.pl /home/geclab/buildroot-2016.11/output/build/linux-headers-3.2.84/include/sound /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/sound arm ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/sound/$$F; done; touch /home/geclab/buildroot-2016.11/output/host/usr/arm-none-linux-gnueabi/sysroot/usr/include/sound/.install