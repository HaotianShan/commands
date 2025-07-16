#!/bin/bash

# Check if disk exists and is empty
echo "Checking disk /dev/vdb..."
sudo file -s /dev/vdb

# If output shows "/dev/vdb: data", it's empty/unformatted
echo "Formatting /dev/vdb as ext4 filesystem..."
sudo mkfs.ext4 /dev/vdb

# Create mount point
echo "Creating mount point /mydata..."
sudo mkdir -p /mydata

# Mount the disk
echo "Mounting /dev/vdb to /mydata..."
sudo mount /dev/vdb /mydata

# Make mount persistent (add to /etc/fstab)
echo "Adding to /etc/fstab..."
DISK_UUID=$(sudo blkid -s UUID -o value /dev/vdb)
echo "UUID=${DISK_UUID} /mydata ext4 defaults,nofail 0 0" | sudo tee -a /etc/fstab

# Verify fstab entry is correct
echo "Verifying fstab entry..."
sudo mount -a

# Verify the mount
echo "Disk information:"
df -h /mydata