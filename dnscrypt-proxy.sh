# Get the latest release link from https://github.com/DNSCrypt/dnscrypt-proxy/releases/latest
# usage chmod +x dnscrypt-proxy.sh then sudo dnscrypt-proxy.sh

echo 'Step 1: Creating folders ~/tmp and ~/dnscrypt-proxy'
mkdir ~/tmp
mkdir ~/dnscrypt-proxy
cd ~/tmp
echo 'Step 2: Downloading and unpacking dnscrypt-proxy-macos-2.0.39.tar.gz'
curl -L https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.0.39/dnscrypt-proxy-macos-2.0.39.tar.gz -o dnscrypt-proxy-macos-2.0.39.tar.gz
tar -xvf dnscrypt-proxy-macos-2.0.39.tar.gz
cd
cp -r ~/tmp/macos/ ~/dnscrypt-proxy
rm -r ~/tmp
cd ~/dnscrypt-proxy
echo 'Step 3: Configuring and starting dnscrypt-proxy'
cp example-dnscrypt-proxy.toml dnscrypt-proxy.toml
sed -i '' "s/# server_names/server_names/" dnscrypt-proxy.toml
sed -i '' "s/'scaleway-fr', //" dnscrypt-proxy.toml
sed -i '' "s/, 'yandex', 'cloudflare'//" dnscrypt-proxy.toml
./dnscrypt-proxy -service install
./dnscrypt-proxy -service start
echo 'Step 4: Setting DNS for Ethernet to 127.0.0.1'
networksetup -setdnsservers Ethernet Empty
dscacheutil -flushcache
networksetup -setdnsservers Ethernet 127.0.0.1
echo 'Step 5: Testing the DNS server used'
nslookup cloudflare.com
