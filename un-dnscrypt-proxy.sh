# usage chmod +x un-dnscrypt-proxy.sh then sudo un-dnscrypt-proxy.sh

# Step 1: Stoping and uninstalling the dnscrypt-proxy service
cd ~/dnscrypt-proxy
./dnscrypt-proxy -service stop
./dnscrypt-proxy -service uninstall

# Step 2: Deleting the dnscrypt-proxy folder
cd
rm -rf ~/dnscrypt-proxy

# Step 3: Setting DNS for Ethernet and Wi-Fi to Google DNS
networksetup -setdnsservers Ethernet Empty
networksetup -setdnsservers Wi-Fi Empty
dscacheutil -flushcache
networksetup -setdnsservers Ethernet 8.8.8.8 8.8.4.4
networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4

# Step 4: Testing the DNS server used
nslookup cloudflare.com
