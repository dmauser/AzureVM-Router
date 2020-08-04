# Deploy Azure VM as Router

Deploy Azure VM (Linux or Windows) with IP forwarder enabled to be used as Router

## Deploy a single Linux VM as Router (IPv4)

Deploy a Linux Router (Ubuntu 18.04-LTS) to an existing Virtual Network (VNET)/Subnet using a Single NIC + IP Forwarding Enabled.

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdmauser%2FAzureVM-Router%2Fmaster%2FLinuxRouter.json)
[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](https%3A%2F%2Fraw.githubusercontent.com%2Fdmauser%2FAzureVM-Router%2Fmaster%2FLinuxRouter.json)

## Deploy a single Windows VM as Router (IPv4 and IPv6)

Deploy a Windows (Server 2019 Core - Small Disk) Router to an existing Virtual Network (VNET)/Subnet using a Single NIC + IP Forwarding Enabled.

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdmauser%2FAzureVM-Router%2Fmaster%2FWinRouter.json)
[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](https%3A%2F%2Fraw.githubusercontent.com%2Fdmauser%2FAzureVM-Router%2Fmaster%2FWinRouter.json)


## Roadmap

- Add VMSS option for both Linux and Windows deployment types
- Add Accellerated Networking option