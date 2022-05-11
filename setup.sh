# Droidian Adaptation for the Xiaomi Redmi note  pro (violet)
# Flashing based on: https://github.com/droidian-releng/android-recovery-flashing-template

# Contains fixes for:
# 1. udev
# 2. mask some crashing services
# 3. wifi

# https://droidian.org

OUTFD=/proc/self/fd/$1;
VENDOR_DEVICE_PROP=`grep ro.product.vendor.device /vendor/build.prop | cut -d "=" -f 2 | awk '{print tolower($0)}'`;

# ui_print <text>
ui_print() { echo -e "ui_print $1\nui_print" > $OUTFD; }

mkdir /r;

# mount droidian rootfs
mount /data/rootfs.img /r;

# Copy files
ui_print "Copying device adaptation files...";

cp -fpr data/droidian/data/70-violet.rules /r/etc/udev/rules.d/70-violet.rules
cp -fpr data/droidian/data/recovery-script.sh /r/usr/local/bin/recovery-script.sh 
cp -fpr data/droidian/data/resolv.conf /r/data/etc/resolv.conf

#Run script to disable crashing services
chroot /r /bin/bash /usr/local/bin/recovery-script.sh

ui_print " thank you @ThomasHastings and @eugenio_g7 and everyone in the community...";

#rm script as its work is done
rm -f /r/usr/local/bin/recovery-script.sh 

# umount rootfs
umount /r;
exit 0;
# flash boot.img
#flash_image /dev/block/bootdevice/by-name/boot boot.img
