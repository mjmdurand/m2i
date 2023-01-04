apt update
apt install apache2 unzip
mkfs.ext3 /dev/xvdf
cd /tmp
mount /dev/xvdf /var/www/html
wget -O /tmp/forty.zip --no-check-certificate https://html5up.net/forty/download
unzip /tmp/forty.zip -d /var/www/html/
echo "/dev/xvdf /var/www/html ext3 defaults,noatime 1 2" | tee -a /etc/fstab
rm -rf /var/www/html/*
umount /dev/xvdf
mount -t ext3 /dev/xvdg /var/www/html/
