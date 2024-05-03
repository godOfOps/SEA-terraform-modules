#!/bin/bash
sudo yum update -y
sudo yum install -y httpd xfsprogs git
sudo systemctl start httpd
sudo systemctl enable httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
DEVICE=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/block-device-mapping/ebs2)
BLOCK=$(ls -l /dev/${DEVICE} | awk '{print $NF}')
sudo mkfs -t xfs /dev/${BLOCK}
sudo mkdir -p /var/log
sudo mount /dev/${BLOCK} /var/log

UUID=$(sudo blkid -s UUID -o value /dev/${BLOCK})
echo "UUID=${UUID}  /var/log  xfs  defaults,nofail  0  2" | sudo tee -a /etc/fstab

sudo rm -fr /var/www/html/*
sudo git clone https://github.com/erdincakgun/RockPaperScissors.git /var/www/html/
sed -i 's/tr/en/' /var/www/html/index.html