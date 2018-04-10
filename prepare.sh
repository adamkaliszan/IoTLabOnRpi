#!/bin/bash

#echo SSH sever on start
sudo systemctl enable ssh
sudo systemctl start ssh

echo "Upgrading the system"
sudo apt-get upgrade

echo "sudo apt-get install mc minicom  avrdude gcc-avr avr-libc git subversion"
sudo apt-get install mc minicom  avrdude gcc-avr avr-libc git subversion 

sudo apt-get install fuse fuse-posixovl lftp r-base

sudo apt-get install pandoc

sudo python3-matplotlib python3-pip 

sudo pip3 install --upgrade pip
sudo pip3 install jupyter urllib3 psutil
sudo pip3 install metakernel

su pi -c "jupyter notebook --generate-config"
echo "Please idit notebook file in directory /home/pi/.jupyter"

#Jupyter notebook on start 
grep -vwE "(^exit 0|su pi -c \"jupyter notebook)" /etc/rc.local > /etc/rc.local2
sudo echo 'su pi -c "jupyter notebook --log-level='\''CRITICAL'\'' --no-browser --notebook-dir=/home/pi/Labs &> /dev/null" &' >> /etc/rc.local2
sudo echo 'exit 0' >> /etc/rc.local2
sudo mv /etc/rc.local2 /etc/rc.local


sudo mkdir /root/scripts/
cd /root
git clone https://github/adamkaliszan/IoTLab

sudo chown pi.pi -R Labs
