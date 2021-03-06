# Serveur NTP

## Installation

Installez le paquet du serveur NTP :

	apt install ntp

## Configuration

Configurez le serveur NTP :

	nano /etc/ntp.conf

pour utiliser les serveurs de temps dans le pool français :

	#
	# NTP Client/Server Configuration
	#

	# Default NTP parameters
	driftfile /var/lib/ntp/ntp.drift
	statistics loopstats peerstats clockstats
	filegen loopstats file loopstats type day enable
	filegen peerstats file peerstats type day enable
	filegen clockstats file clockstats type day enable

	# Time servers in France
	server 0.fr.pool.ntp.org iburst
	server 1.fr.pool.ntp.org iburst
	server 2.fr.pool.ntp.org iburst
	server 3.fr.pool.ntp.org iburst

	# By default, exchange time with everybody, but don't allow configuration.
	restrict -4 default kod notrap nomodify nopeer noquery
	restrict -6 default kod notrap nomodify nopeer noquery

	# Local users may interrogate the ntp server more closely.
	restrict 127.0.0.1
	restrict ::1

## Lancement

Redémarrez le service ntp :

	systemctl restart ntp
