#!/bin/sh

# exit when any command fails
set -e

#markup
yellow="\033[38;5;11m"
green="\e[32m"
bold="\033[1m"
reset="\033[0m"

create_args(){
echo " "
echo -e "${bold}If your printer is connected to the box, one of the following should be your serial device port:${reset}"
ls /dev/tty* | grep -v /dev/ttyS
echo " "
read -p $'Enter your printer USB serial port (Ex: \033[1m/dev/ttyUSB0\033[0m): ' SERIALPORT;

read -p $'Enter the baudrate of your printer serial port (Ex: \033[1m115200\033[0m) : ' BAUDRATE;

read -p $'Enter a port on which to access this server (Ex: \033[1m10001\033[0m): ' LOCALPORT;

mkdir -p /root/tcp2serial-bridge
echo "-P ${LOCALPORT} ${SERIALPORT} ${BAUDRATE}" > /root/tcp2serial-bridge/args

. /lib/functions/network.sh; network_find_wan NET_IF; network_get_ipaddr NET_ADDR "${NET_IF}";
BOXIP=$(echo ${NET_ADDR})


echo " "
echo -e "You'll be able to change this variables by editing \033[1m/root/tcp2serial-bridge/args\033[0m"
echo " "
sleep 2
}

install_dependencies(){
    echo -e "\033[1mInstalling dependencies...\033[0m"
    echo " "
    opkg update && opkg install python3 python3-pip
    pip install pyserial
    
}

download_pyserial_tcp2serial_bridge(){
echo -e "\033[1mDownloading pyserial tcp to serial bridge...\033[0m"
echo ""

cd /root/tcp2serial-bridge
wget https://raw.githubusercontent.com/pyserial/pyserial/master/examples/tcp_serial_redirect.py
chmod +x ./tcp_serial_redirect.py
}

create_service(){
echo -e "\033[1mCreating TCP to Serial Service...\033[0m"
echo " "
cat << "EOF" > /etc/init.d/tcp2serial-bridge
#!/bin/sh /etc/rc.common

START=91
STOP=10
USE_PROCD=1


start_service() {
    procd_open_instance
    procd_set_param command /usr/bin/python3 \
        /root/tcp2serial-bridge/tcp_serial_redirect.py $(cat /root/tcp2serial-bridge/args)
    procd_set_param respawn
    procd_set_param stdout 1
    procd_set_param stderr 1
    procd_close_instance
}
EOF
sleep 1;
chmod +x /etc/init.d/tcp2serial-bridge;
/etc/init.d/tcp2serial-bridge enable

}

create_args;
install_dependencies;
download_pyserial_tcp2serial_bridge;
create_service;

    
echo -e "You can now access the printer on \033[1m${SERIALPORT}\033[0m through TCP by using telnet or netcat on \033[1m${BOXIP}\033[0m and port \033[1m${LOCALPORT}\033[0m"
echo " "
echo "Reboot the box for changes to take effect"
read -p $'Press [ENTER] to \033[1mreboot\033[0m...or [ctrl+c] to \033[1mexit\033[0m'
reboot
