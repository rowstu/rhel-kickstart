mount -t iso9660 -o loop ~/Downloads/CentOS-7-x86_64-DVD-1511.iso /mnt
rsync -avz /mnt/* /root/c7image

cat <<EOF > /root/c7image/isolinux/isolinux.cfg

default vesamenu.c32
timeout 0

menu background splash.png
menu margin 14
menu rows 6


label CentOS7-db
  menu label ^Install CentOS7 Dual Boot with Windows
  kernel vmlinuz
  append initrd=initrd.img ks=http://repo.cs.man.ac.uk/pub/ks/centos/c7dualboot.ks

label CentOS7
  menu label ^Install CentOS7 formatting the whole disk
  kernel vmlinuz
  append initrd=initrd.img ks=http://repo.cs.man.ac.uk/pub/ks/centos/c7desktop.ks

label CentOS7-custom
  menu label ^Install CentOS7 with manual disk partitioning
  kernel vmlinuz
  append initrd=initrd.img ks=http://repo.cs.man.ac.uk/pub/ks/centos/c7custom.ks
EOF

cd /root
mkisofs -o /root/new-c7.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -T .
