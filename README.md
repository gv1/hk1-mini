# hk1-mini
Slackware / Ubuntu on hk1 mini

Issue: kernel is not SMP. 

Slackware 14.2

make a bootable sd card:

method 1:
        
    dd if=./idbloader.img of=/dev/sdX seek=$((0x40))
    dd if=./uboot.img of=/dev/sdX seek=$((0x4000)) conv=notrunc # $((0x4000))
    dd if=./trust.img of=/dev/sdX seek=$((0x6000)) conv=notrunc # $((0x6000))
  
create a new partition like:

    Device     Boot  Start      End  Sectors  Id Type
    /dev/sdX1        32768 31116287 31083520  83 Linux
        
    partprobe /dev/sdX
    mkfs.ext4 /dev/sdX1
   
    mount and copy : rk3229-evb.dtb, extlinux/, zImage, initrd-armv7.gz ( for slackware setup )
  
    use appropriate extlinux/extlinux.conf for setup 
  
    Copy Slackware for arm install files to Slackware-14.2
  
    boot to setup
  
    install from pre mounted directory /mnt/slackware-14.2/slackware 
  
    once installation is finished use extlinux/extlinux.conf for slackware.
  
    remember to add either a swap partition or file
  
    reboot!
 
method 2:
  
    dd if=./sdcard.first10MB.img of=/dev/sdX 
  
    fdisk /dev/sdX and continue as above.
  
  
 Ubuntu. using ubuntu-mate 16.04 for raspberry pi:
 
    setup bootable sdcard as above. get ubuntu ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img.gz
    /sbin/fdisk -l ./ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img
     
    Disk ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img: 4.7 GiB, 5000000000 bytes, 9765625 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x1d8c09f0

    Device Boot  Start     End  Sectors  Size Id Type
    ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img1        2048  131071  129024   63M  c W95 FAT
    ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img2      131072 9764863 9633792  4.6G 83 Linux

  
now mount second partition like:

    mount -o loop,offset=$((131072*512)) ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img /cdrom -r/cdrom -r  
 
    mount /dev/sdX1 /mnt
    rsync -az /cdrom/ /mnt

edit /etc/fstab to remove boot mount, and also change root to /dev/sdX1

    proc            /proc           proc    defaults          0       0
    /dev/mmcblk0p1  /               ext4   defaults,noatime  0       1
    # /dev/mmcblk0p1  /boot/          vfat    defaults          0       2
    /swap.img       swap            swap    defaults        0  0



extlinux same for slackware ( not slackware setup )

remember to add either a swap partition or swap file.

reboot!

Swap:

    # 2GB
    dd if=/dev/zero of=swap.img count=$((1024*1024*2*2)
    mkswap swap.img
    swapon swap.img

    /etc/fstab:
    /swap.img swap swap defaults 0 0


Slackware Links:

    http://arm.slackware.com/
    http://arm.slackware.com/getslack/
    ftp://ftp.arm.slackware.com/slackwarearm/slackwarearm-14.2/isolinux/initrd-armv7.img
    ftp://ftp.arm.slackware.com/slackwarearm/slackwarearm-14.2/

Ubuntu MATE links:

    https://ubuntu-mate.org/
    https://ubuntu-mate.org/raspberry-pi/

Keeping multiple distributions on same SD card:

eg, once slackware is installed and ok:

    mount sdcard to /mnt
    cd /mnt
    mkdir slackware-14.2
    mv * slackware-14.2
    mv slackware-14.2/{zImage, extlinux/, initrd*} .
    ln -s slackware-14.2/* .
    sync
    
similarly move files for other distributions too.

    mount sdcard to /mnt
    cd /mnt
    mkdir ubuntu-mate-16.04
    mv * ubuntu-mate-16.04
    mv ubuntu-mate-16.04/{slackware-14.2, zImage, extlinux/, initrd*} .

