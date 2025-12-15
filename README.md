# README
---
## Why you need PorKaTe (Portable Kali Terminal)?
Are you tired of using slow virtual machines to use Kali Linux? 
Most of the time you only need the terminal and all his tools.
Well I'm tired, so I built this simple docker image containing the latest version of kali and adding all the following packages
- hexedit
- strongswan
- libstrongswan-extra-plugins
- dkms
- lynx
- s-nail
- alien
- nsis
- httptunnel
- net-tools
- ettercap
- ptunnel
- nmap
- openssl
- hashdeep
- p7zip-full
- apache2
- vsftpd

## Installation and run
This app needs docker to be built and runned, so each time you want to use it make sure to have docker started.
Of course, you need to have docker installed :) 

1) clone this repository
```bash git clone https://github.com/PorKaTe/PorKaTe.git
```

2) change directory 
```bash
cd PorKaTe
```
    
3) give permissions to file "start_kali.sh" to execute with commands:  
```bash
sudo chmod +x start_kali.sh
```
4) build the docker image with command:  
```bash
sudo ./start_kali.sh build
```
Remember: you need to build the image only once, unless you want to rebuild it (see step 6)

5) run the kali terminal with command: 
 
```bash
sudo ./start_kali.sh run
```
(Run this command each time you want to use the kali terminal, in this way you will not need to build the image again)


lunching this command the first time will create a folder named "workspace" in the same directory where the script is located. This folder is binded to the /root/workspace folder inside the kali terminal, so you can easily share files between your host machine and the kali terminal.  
You can change the content of this folder from your host machine and find the changes inside the kali terminal and vice versa.

6) (optional) if you want to rebuild the image from scratch (for example if you want to update kali linux) use command:  
```bash
sudo ./start_kali.sh rebuild
```  
7) build and run in a single command:  
```bash
sudo ./start_kali.sh
``` 
8) Enjoy your portable kali terminal :)
