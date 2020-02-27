set DNSinUse to do shell script "networksetup -getdnsservers Ethernet"
set question to display dialog "The current DNS server(s):" & return & DNSinUse buttons {"Set DNS", "Cancel"}
set answer to button returned of question
if answer is equal to "Set DNS" then
	set question to display dialog "Please select" buttons {"Google DNS", "dnscrypt-proxy", "Cancel"}
	set answer to button returned of question
	if answer is equal to "Google DNS" then
		do shell script "networksetup -setdnsservers Ethernet 8.8.8.8 8.8.4.4"
	end if
	if answer is equal to "dnscrypt-proxy" then
		do shell script "networksetup -setdnsservers Ethernet 127.0.0.1"
	end if
end if
set NewDNS to do shell script "networksetup -getdnsservers Ethernet"
display dialog "The new DNS server(s):" & return & NewDNS buttons {"OK"}
