# Get the latest dnscrypt-proxy-macos release link from https://github.com/DNSCrypt/dnscrypt-proxy/releases/latest

# Step 1: Creating folders ~/tmp and ~/dnscrypt-proxy
mkdir ~/tmp
mkdir ~/dnscrypt-proxy
cd ~/tmp

# Step 2: Downloading and unpacking dnscrypt-proxy-macos-2.0.39.tar.gz
curl -L https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.0.39/dnscrypt-proxy-macos-2.0.39.tar.gz -o dnscrypt-proxy-macos-2.0.39.tar.gz
tar -xvf dnscrypt-proxy-macos-2.0.39.tar.gz
cd
cp -r ~/tmp/macos/ ~/dnscrypt-proxy
rm -r ~/tmp
cd ~/dnscrypt-proxy

# Step 3: Configuring for Google DoH
cp example-dnscrypt-proxy.toml dnscrypt-proxy.toml
sed -i '' "s/# server_names/server_names/" dnscrypt-proxy.toml
sed -i '' "s/'scaleway-fr', //" dnscrypt-proxy.toml
sed -i '' "s/, 'yandex'//" dnscrypt-proxy.toml

# If you want to use Cloudflare too, remove the next line
sed -i '' "s/, 'cloudflare'//" dnscrypt-proxy.toml

# Disable fallback resolvers (non-https DNS) and netprobe
sed -i '' "s/fallback_resolvers/# fallback_resolvers/" dnscrypt-proxy.toml
sed -i '' "s/ignore_system_dns/# ignore_system_dns/" dnscrypt-proxy.toml
sed -i '' "s/netprobe_timeout/# netprobe_timeout/" dnscrypt-proxy.toml
sed -i '' "s/netprobe_address/# netprobe_address/" dnscrypt-proxy.toml

# Step 4: Installing and starting the dnscrypt-proxy service
./dnscrypt-proxy -service install
./dnscrypt-proxy -service start

# Step 5: Setting DNS for Ethernet and Wi-Fi to 127.0.0.1
networksetup -setdnsservers Ethernet Empty
networksetup -setdnsservers Wi-Fi Empty
dscacheutil -flushcache
networksetup -setdnsservers Ethernet 127.0.0.1
networksetup -setdnsservers Wi-Fi 127.0.0.1

# Step 6: Testing the DNS server used
nslookup cloudflare.com
