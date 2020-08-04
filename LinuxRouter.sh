# These actions will be run at provisioning time
# Most of these commands are ephemeral, so you will probably have to rerun them if you reboot the VM

# Enable IP forwarding
sudo -i sysctl -w net.ipv4.ip_forward=1

# Install Quagga ("sudo vtysh" to configure)
sudo apt update
sudo apt-get install quagga -y
sudo touch /etc/quagga/zebra.conf
sudo touch /etc/quagga/bgpd.conf
sudo systemctl enable quagga
sudo systemctl restart quagga
sudo systemctl enable bgpd
sudo systemctl restart bgpd

# Install StrongSwan
# See https://github.com/Azure/Azure-vpn-config-samples/tree/master/StrongSwan/5.3.5
sudo apt install strongswan -y
sudo mv /etc/ipsec.conf /etc/ipsec.conf.bak
sudo mv /etc/ipsec.secrets /etc/ipsec.secrets.bak
sudo wget https://raw.githubusercontent.com/dmauser/LinuxNVA/master/ipsec.conf -P /etc/
sudo wget https://raw.githubusercontent.com/dmauser/LinuxNVA/master/ipsec.secrets -P /etc/
sudo wget https://raw.githubusercontent.com/dmauser/LinuxNVA/master/ipsec-notify.sh -P /usr/local/sbin/
sudo chmod 644 /etc/ipsec.conf
sudo chmod 600 /etc/ipsec.secrets
sudo chmod 755 /usr/local/sbin/ipsec-notify.sh
sudo apparmor_parser -R /etc/apparmor.d/usr.lib.ipsec.charon
sudo apparmor_parser -R /etc/apparmor.d/usr.lib.ipsec.stroke
sudo ln -s /etc/apparmor.d/usr.lib.ipsec.charon /etc/apparmor.d/disable/
sudo ln -s /etc/apparmor.d/usr.lib.ipsec.stroke /etc/apparmor.d/disable/
sudo ipsec restart