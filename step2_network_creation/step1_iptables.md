# Setting up Iptables to route network connections.


Do these steps as root.

1. Create /etc/sysctl.d/99-ipforward.conf to allow the headnode to route network traffic.

  - vi /etc/sysctl.d/99-ipforward.conf

  - Add `net.ipv4.ip_forward = 1`

  - Save the file

2. Install iptables package. Iptables is an utility program to filter network traffic.

```
   sudo su -
   apt install iptables
```

3. Set the Iptables filtering rules.
```
  sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
  sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
  sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
```

4. Make Iptables configuration persistent with iptables-persistent service.
```
   sudo apt install iptables-persistent
   netfilter-persistent save
```
Iptables-persistent service will automatically load the iptables rules on boot up.

5. Check the Iptables rules.
```
   sudo iptables -t nat -L -n -v
```
