#Enable IP Forwarding in all interfaces
Set-NetIPInterface -Forwarding Enabled

#Enable ICMPv4 and ICMPv6
Set-NetfirewallRule -Name FPS-ICMP4-ERQ-In -Enable True -Profile Any
Set-NetfirewallRule -Name FPS-ICMP6-ERQ-In -Enable True -Profile Any