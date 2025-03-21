[Documentation](https://www.virtualbox.org/manual/ch06.html#network_hostonly)

---


# 6.7. Host-Only Networking
Host-only networking can be thought of as a hybrid between the bridged and internal networking modes. As with bridged networking, the virtual machines can talk to each other and the host as if they were connected through a physical Ethernet switch. As with internal networking, a physical networking interface need not be present, and the virtual machines cannot talk to the world outside the host since they are not connected to a physical networking interface.

When host-only networking is used, Oracle VM VirtualBox creates a new software interface on the host which then appears next to your existing network interfaces. In other words, whereas with bridged networking an existing physical interface is used to attach virtual machines to, with host-only networking a new loopback interface is created on the host. And whereas with internal networking, the traffic between the virtual machines cannot be seen, the traffic on the loopback interface on the host can be intercepted.

```text
Hosts running recent macOS versions do not support host-only adapters. These adapters are replaced by host-only networks, which define a network mask and an IP address range, where the host network interface receives the lowest address in the range.

The host network interface gets added and removed dynamically by the operating system, whenever a host-only network is used by virtual machines.

On macOS hosts, choose the Host-Only Network option when configuring a network adapter. The Host-Only Adapter option is provided for legacy support.
```

Host-only networking is particularly useful for preconfigured virtual appliances, where multiple virtual machines are shipped together and designed to cooperate. For example, one virtual machine may contain a web server and a second one a database, and since they are intended to talk to each other, the appliance can instruct Oracle VM VirtualBox to set up a host-only network for the two. A second, bridged, network would then connect the web server to the outside world to serve data to, but the outside world cannot connect to the database.

To enable a host-only network interface for a virtual machine, do either of the following:

- Go to the Network page in the virtual machine's Settings dialog and select an Adapter tab. Ensure that the Enable Network Adapter check box is selected and choose Host-Only Adapter for the Attached To field.

- On the command line, use VBoxManage modifyvm vmname --nicx hostonly. See Section 8.10, “VBoxManage modifyvm”.

For host-only networking, as with internal networking, you may find the DHCP server useful that is built into Oracle VM VirtualBox. This is enabled by default and manages the IP addresses in the host-only network. Without the DHCP server you would need to configure all IP addresses statically.

- In VirtualBox Manager you can configure the DHCP server by choosing File, Tools, Network Manager. The Network Manager window lists all host-only networks which are presently in use. Select the network name and then use the DHCP Server tab to configure DHCP server settings. See Section 6.11, “Network Manager”.

- Alternatively, you can use the VBoxManage dhcpserver command. See Section 8.50, “VBoxManage dhcpserver”.

```text
On Linux and macOS hosts the number of host-only interfaces is limited to 128. There is no such limit for Oracle Solaris and Windows hosts.
```

On Linux, macOS and Solaris Oracle VM VirtualBox will only allow IP addresses in 192.168.56.0/21 range to be assigned to host-only adapters. For IPv6 only link-local addresses are allowed. If other ranges are desired, they can be enabled by creating /etc/vbox/networks.conf and specifying allowed ranges there. For example, to allow 10.0.0.0/8 and 192.168.0.0/16 IPv4 ranges as well as 2001::/64 range put the following lines into /etc/vbox/networks.conf:

      * 10.0.0.0/8 192.168.0.0/16
      * 2001::/64
      
Lines starting with the hash # are ignored. The following example allows any addresses, effectively disabling range control:

      * 0.0.0.0/0 ::/0
      
If the file exists, but no ranges are specified in it, no addresses will be assigned to host-only adapters. The following example effectively disables all ranges:

      # No addresses are allowed for host-only adapters