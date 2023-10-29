#!/usr/bin/env bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}Fatal error: ${plain} Please run this script with root privilege \n " && exit 1
# check if wstunnel installed
if (/bin/wstunnel);
echo " wstunnel already installed"
echo "do you want edit configure options or force update wstunnel?"
echo "1 - edit configs"
echo "2 - force update"
fi
# update and install requirments
apt update && apt upgrade -y
apt install wget tar -y

#install wstunnel and add to environment variables
wget "https://github.com/erebe/wstunnel/releases/download/v7.7.2/wstunnel_7.7.2_linux_amd64.tar.gz"
tar -zxvf wstunnel_7.7.2_linux_amd64.tar.gz
rm LICENSE
rm README.md
chmod +x wstunnel
mv wstunnel /bin/

#create systemd file and configure options
wstunnel_mode=0
do
    echo "what mode do you want to use WSTunnel?"
    echo "1 - server"
    echo "2 - client"
    read $wstunnel_mode
    while({$wstunnel_mode !=1||2})
done

if ({$wstunnel_mode==1});
    echo "you selected server mode, let configure some options"
    echo "please tell me the port you want wstunnel to listen:"
    echo "[default is 8080]"
fi