# Lab 40 - sanitized template only.
# Run elevated on the Windows Hercules host.
# Replace placeholders with lab-private addresses.

$HostIp = "<HOST_LAN_IP>"
$ZosIp  = "<ZOS_GUEST_IP>"

netsh interface portproxy add v4tov4 listenaddress=$HostIp listenport=2121 connectaddress=$ZosIp connectport=21

50000..50009 | ForEach-Object {
    netsh interface portproxy add v4tov4 listenaddress=$HostIp listenport=$_ connectaddress=$ZosIp connectport=$_
}

netsh interface portproxy show all
