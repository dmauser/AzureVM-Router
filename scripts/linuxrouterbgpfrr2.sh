#!/bin/sh
# Parameters
asn_frr=$1
bgp_routerId=$2
bgp_network1=$3
bgp_network2=$4
routeserver_IP1=$5
routeserver_IP2=$6

# Enable IPv4 and IPv6 forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
sed -i "/net.ipv4.ip_forward=1/ s/# *//" /etc/sysctl.conf
sed -i "/net.ipv6.conf.all.forwarding=1/ s/# *//" /etc/sysctl.conf

## Install the frr routing daemon
echo "Installing frr"
curl -s https://deb.frrouting.org/frr/keys.asc | sudo apt-key add -
FRRVER="frr-stable"
echo deb https://deb.frrouting.org/frr $(lsb_release -s -c) $FRRVER | sudo tee -a /etc/apt/sources.list.d/frr.list

apt-get -y update

apt-get -y install frr frr-pythontools

##  run the updates and ensure the packages are up to date and there is no new version available for the packages
sudo apt-get -y update --fix-missing

echo "Installing IPTables-Persistent"
echo iptables-persistent iptables-persistent/autosave_v4 boolean false | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean false | sudo debconf-set-selections
apt-get -y install iptables-persistent

# Enable NAT to Internet
iptables -t nat -A POSTROUTING -d 10.0.0.0/8 -j ACCEPT
iptables -t nat -A POSTROUTING -d 172.16.0.0/12 -j ACCEPT
iptables -t nat -A POSTROUTING -d 192.168.0.0/16 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Save to IPTables file for persistence on reboot
iptables-save > /etc/iptables/rules.v4

## Create the configuration files for frr daemon
echo "add bgpd in daemon config file"
sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons

echo "add FRR config"
cat <<EOF > /etc/frr/frr.conf
!
router bgp $asn_frr
 bgp router-id $bgp_routerId
 no bgp ebgp-requires-policy
 no bgp network import-check
 network $bgp_network1
 network $bgp_network2
 network $bgp_network3
 neighbor $routeserver_IP1 remote-as 65515
 neighbor $routeserver_IP1 ebgp-multihop 255
 neighbor $routeserver_IP1 soft-reconfiguration inbound
 neighbor $routeserver_IP2 remote-as 65515
 neighbor $routeserver_IP2 ebgp-multihop 255
 neighbor $routeserver_IP2 soft-reconfiguration inbound
!
 address-family ipv6
 exit-address-family
 exit
!
line vty
!
EOF

## to start daemons at system startup
echo "enable frr at system startup"
systemctl enable frr

## run the daemons
echo "start frr daemons"
systemctl restart frr

sudo adduser azureuser frrvty
sudo adduser azureuser frr