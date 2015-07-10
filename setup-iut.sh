#! /bin/sh

#
# Configure system banners, and apt sources
#

# Configure system banners
cp -fv config/issue /etc/issue
cp -fv config/issue.net /etc/issue.net
rm -fv /etc/motd

# Setup apt sources to use our local mirror
if whiptail --title "APT setup" --yesno "Use local mirror server ?" --defaultno 10 50; then
	# Configure APT sources
	cp -fv config/sources.list.iut /etc/apt/sources.list
	# Update package database
	apt update
fi

# Setup NTP client to use our local time server
if whiptail --title "NTP setup" --yesno "Use local time server ?" --defaultno 10 50; then
	# Install NTP package
	apt install -y ntp
	# Configure NTP server
	cp -fv config/ntp.conf.iut /etc/ntp.conf
	# Restart NTP service
	systemctl restart ntp
fi

# Setup CNTLM for authentication with our local proxy server
if whiptail --title "CNTLM setup" --yesno "Use local proxy server ?" --defaultno 10 50; then
	# Install CNTLM package
	apt install -y cntlm
	# Disable CNTLM service
	systemctl stop cntlm
	systemctl disable cntlm
	# Configure CNTLM
	cp -fv config/cntlm.conf /etc/cntlm.conf
	# Copy the functions to start and stop the local proxy in bashrc
	cat config/proxy.sh >> /etc/bash.bashrc
fi
