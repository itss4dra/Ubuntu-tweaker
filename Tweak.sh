
optimize_system() {
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt update
    sudo apt upgrade -y
    enable_tcp_bbr
    sudo apt autoremove -y
    sudo apt clean
    
    configure_swappiness
    disable_ipv6
    echo "System optimization complete!"
}
enable_tcp_bbr() {
    echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv4.icmp_echo_ignore_all=1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    echo "TCP BBR enabled."
}
disable_tcp_bbr() {
    sudo sed -i '/net.ipv4.tcp_congestion_control=bbr/d' /etc/sysctl.conf
    sudo sysctl -p
    echo "TCP BBR disabled."
}


configure_swappiness() {
    echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    echo "Swappiness configured."
}

disable_ipv6() {
    echo "net.ipv6.conf.all.disable_ipv6=1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    echo "IPv6 disabled."
}

rollback_changes() {
    disable_tcp_bbr
    
    echo "Rollback complete!"
}

echo "=================================="
echo " Ubuntu Tweaker "
echo "https://github.com/itss4dra"
echo "=================================="
echo ""
echo "1. Optimize System"
echo "2. Rollback Changes"
echo "0. Exit"
echo ""

read -p "Enter your choice: " choice
echo ""

case $choice in
    1)
        optimize_system
    ;;
    2)
        rollback_changes
    ;;
    0)
        exit
    ;;
    *)
        echo "Invalid choice. Exiting."
    ;;
esac
