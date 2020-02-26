# usage chmod +x un-dnscrypt-proxy.sh then sudo un-dnscrypt-proxy.sh

echo 'Step 1: Stoping and uninstalling the dnscrypt-proxy service'
cd ~/dnscrypt-proxy
./dnscrypt-proxy -service stop
./dnscrypt-proxy -service uninstall

echo 'Step 2: Deleting the dnscrypt-proxy folder'
cd
rm -rf ~/dnscrypt-proxy

echo 'Step 3: Setting DNS for Ethernet to Google DNS'
networksetup -setdnsservers Ethernet Empty
dscacheutil -flushcache
networksetup -setdnsservers Ethernet 8.8.8.8 8.8.4.4

echo 'Step 4: Testing the DNS server used'
nslookup cloudflare.com
