# ser2net-bridge
Uses the ser2net package to establish a bridge between a serial device path and a tcp port. Check Releases page for more details and binaries.

### tcp2serial-bridge (alternative)
<details>
  <summary>Click to expand!</summary>
 A bash script to install and run a TCP to serial bridge on OpenWrt. All commands sent through TCP will be forwarded to the specified serial port and vice versa. Based on pyserial example.
 
 ## Instructions:
 
 **1. Clone the repo:**
```
opkg update && opkg install git-http
git clone https://github.com/ihrapsa/tcp2serial-bridge.git
```
 **2. Install:**
```
cd tcp2serial-bridge
chmod +x install-tcp2serial-bridge.sh
./install-tcp2serial-bridge.sh
```
 **3. Follow the prompts to setup the bridge arguments and reboot after it's all done.**
</details>

