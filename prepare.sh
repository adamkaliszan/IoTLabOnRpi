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

#Downloading template notebooks
sudo mkdir /root/scripts/
cd /root
sudo git clone https://github.com/adamkaliszan/IoTLabOnRpi.git
sudo cp -f IoTLabOnRpi/ipynb/* /home/pi/Labs/
chown -R pi.pi /home/pi/Labs/

#Preparing /etc/rc.local startup script 
grep -vwE "(^exit 0|su pi -c \"jupyter notebook|IoTLabOnRpi)" /etc/rc.local > /etc/rc.local2
sudo echo 'su pi -c "jupyter notebook --log-level='\''CRITICAL'\'' --no-browser --notebook-dir=/home/pi/Labs &> /dev/null" &' >> /etc/rc.local2
sudo echo 'cd /root/IoTLabOnRpi/ && git pull && cd /' >> /etc/rc.local2
sudo echo 'cd /root/IoTLabOnRpi/ && ./update.sh && cd /' >> /etc/rc.local2
sudo echo '/root/IoTLabOnRpi/Scripts/restoreLabs.sh' >> /etc/rc.local2
sudo echo 'exit 0' >> /etc/rc.local2

sudo mv /etc/rc.local2 /etc/rc.local


