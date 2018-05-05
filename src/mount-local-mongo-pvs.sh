#!/bin/bash
disks=$(lsblk|grep nvme|awk '{print $1}')
echo "Located disks $disks"
for i in $disks;
do
(sudo blkid -t TYPE=xfs | grep /dev/$i) || (sudo wipefs -fa /dev/$i && mkfs.xfs /dev/$i)
sudo mkdir -p /mnt/disks/$i
sudo chmod -R 777 /mnt
sudo mount /dev/$i /mnt/disks/$i
if [[ $? -eq 0 ]]
then
echo "Mounted $i"
echo "/dev/$i   /mnt/disks/$i       xfs    defaults,nofail   0   2" > /tmp/mnt_entry
sudo sh -c 'cat /tmp/mnt_entry  >> /etc/fstab'
fi
done
