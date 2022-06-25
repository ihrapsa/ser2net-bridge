# tcp2serial-bridge
 A bash script to install and run a TCP to serial bridge on OpenWrt. All commands sent through TCP will be forrwarded to the specified serial port and vice versa. Based on pyserial example.
 
 ## Instructions:
 
 **1. Clone the repo:**
```
git clone https://github.com/ihrapsa/tcp2serial-bridge.git
```
 **2. Install:**
```
cd tcp2serial-bridge
chmod +x install-tcp2serial-bridge.sh
./install-tcp2serial-bridge.sh
```
 **3. Follow the prompts to setup the bridge arguments and reboot after it's all done.**
