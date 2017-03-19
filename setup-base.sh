#! /bin/sh

#
# Base system configuration
#

# Setup apt sources in France
cp -fv config/sources.list.france /etc/apt/sources.list
# Update the package database and the system
apt update
apt upgrade
# Purge unwanted applications
apt purge -y vim-tiny
# Install some useful applications
apt install -y tree vim git minicom mtr-tiny tcpdump iperf nmap htop
# Cleanup the packages
apt -y autoremove
apt -y autoclean
# Configure Bash
cp -fv config/bash.bashrc /etc/bash.bashrc
rm -fv /etc/skel/.bashrc
# Remove local bashrc files
rm -fv /root/.bashrc
for USER in $(ls /home); do
	if [ "$USER" = 'lost+found' ]; then continue; fi
	rm -fv /home/$USER/.bashrc
done
# Configure Nano
#cp -fv config/conf.nanorc /usr/share/nano/conf.nanorc
#cp -v /etc/nanorc /etc/nanorc.$DATE
#cp -fv config/nanorc /etc/nanorc
# Configure Vim
sed -i 's/^"syntax on/syntax on/' /etc/vim/vimrc
sed -i 's/^"set background/set background/' /etc/vim/vimrc
# Configure minicom
cp -fv config/minirc.dfl /etc/minicom/minirc.dfl
# Install VirtualBox guest additions
if whiptail --title "VirtualBox setup" --yesno "Install VirtualBox guest additions ?" --defaultno 10 50; then
	apt install -y --no-install-recommends virtualbox-guest-dkms linux-headers-amd64
fi
# Zero GRUB timeout
if whiptail --title "GRUB setup" --yesno "Zero GRUB timeout ?" --defaultno 10 50; then
	sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
	update-grub
fi
