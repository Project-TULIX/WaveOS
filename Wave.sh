#!/bin/sh
# Author : Team TULIX
# Version : 1.1

#ROM Name
ROM=WaveOS

#Figlet
echo " "
echo " Welcome to Project: "
echo " "
tput setaf 1; echo "  ██████████ ██     ██ ██       ██ ██     ██ "
tput setaf 2; echo " ░░░░░██░░░ ░██    ░██░██      ░██░░██   ██  "
tput setaf 3; echo "     ░██    ░██    ░██░██      ░██ ░░██ ██   "
tput setaf 4; echo "     ░██    ░██    ░██░██      ░██  ░░███    "
tput setaf 5; echo "     ░██    ░██    ░██░██      ░██   ██░██   "
tput setaf 6; echo "     ░██    ░██    ░██░██      ░██  ██ ░░██  "
tput setaf 7; echo "     ░██    ░░███████ ░████████░██ ██   ░░██ "
tput setaf 8; echo "     ░░      ░░░░░░░  ░░░░░░░░ ░░ ░░     ░░  "

sleep 2
echo " "
echo " "

#Requirements
tput setaf 10; echo " This script will build $ROM for you "
sleep 1
echo " "
tput setaf 1; echo " Please make sure that your machine has following requirements: "
tput sgr0; sleep 1
echo " "
echo " (A) A Debian Distro (Ubuntu recommended) "
sleep 1.5
echo " (B) 200GB of Internet (Faster internet will reduce syncing time) "
sleep 1.5
echo " (C) A Machine with at least 16GB of RAM (More RAM will reduce Comiplation time) "
sleep 1.5
echo " (D) 250GB of free storage (having an SSD will reduce compilation time)  "
sleep 1.5
echo " (E) A Quad Core CPU (Newer x86 CPUs recommended) "
sleep 1.5
echo " "
echo " "
tput setaf 13; read -p " Do you have following requirements(y/n)? " answer; tput sgr0
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo " "
    sleep 1
    echo " Great, We can now start building $ROM "
    echo " "
    sleep 1
    echo " Build will start in 5 seconds, Press Ctrl+C to abort "
    echo " "
    echo " 5 "
    sleep 1
    echo " 4 "
    sleep 1
    echo " 3 "
    sleep 1
    echo " 2 "
    sleep 1
    echo " 1 "
    sleep 1
    echo " Let's rock "
    echo " "
    
    #Packages
    echo " Collecting Packages "
    echo " "
    sudo add-apt-repository ppa:openjdk-r/ppa -y
    sudo apt-get update -y
    sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig libncurses5 aptitude -y
    sudo aptitude install libssl-dev -y
    echo " "
    echo " Package installation completed "
    echo " "
    
    #Enviroment setup
    echo " Setting up Android Build Enviroment "
    echo " "
    rm -rf ~/.bin
    mkdir ~/.bin
    PATH=~/.bin:$PATH
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
    chmod a+x ~/.bin/repo
    echo " "
    echo " Setup complete "
    echo " "
    
    #Repo Sync
    echo " Collecting Sources "
    echo " "
    mkdir ~/$ROM
    cd ~/$ROM
    echo " Initialising repo "
    echo " "
     repo init -u https://github.com/Wave-Project/manifest -b r
    echo " "
    echo " Syncing repo "
    echo " "
     repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
    echo " "
    echo " Repo sync complete "
    echo " "
    
    #Tree Collection
    echo " Collecting TULIX repos "
    echo " "
    git clone https://github.com/Project-TULIX/wave_device_xiaomi_tulip.git device/xiaomi/tulip && git clone https://github.com/Project-TULIX/wave-device_xiaomi_sdm660-common.git device/xiaomi/sdm660-common && git clone https://github.com/Project-TULIX/vendor_xiaomi_tulip-common.git vendor/xiaomi/sdm660-common && git clone https://github.com/PixelPlusUI-Devices/vendor_xiaomi_tulip.git vendor/xiaomi/tulip && git clone https://github.com/Sixzz9/kernel-xiaomi-sdm660.git -b eas kernel/xiaomi/tulip && rm -rf hardware/qcom-caf/msm8998/display && rm -rf hardware/qcom-caf/msm8998/media && rm -rf hardware/qcom-caf/msm8998/audio && git clone https://github.com/XelXen/hardware_qcom-caf_display_msm8998.git -b 11 hardware/qcom-caf/msm8998/display && git clone https://github.com/XelXen/hardware_qcom-caf_media_msm8998.git -b 11 hardware/qcom-caf/msm8998/media && git clone https://github.com/XelXen/hardware_qcom-caf_audio_msm8998.git -b 11 hardware/qcom-caf/msm8998/audio
    echo " "
    echo " TULIX sync complete "
    echo " "
    
    #Build
    tput setaf 13; read -p " Do you want GAPPS edition(y/n)? " answer; tput sgr0
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo " "
        echo " Starting build "
        echo " "
        . build/envsetup.sh
        brunch tulip
        tput setaf 10; echo " Build is complete, you can verify by checking the zip file in out/target/product/tulip "
        tput sgr0
    else
        echo " "
        echo " Starting build "
        echo " "
        . build/envsetup.sh
        export VANILLA_BUILD=true
        brunch tulip
        tput setaf 10; echo " Build is complete, you can verify by checking the zip file in out/target/product/tulip "
        tput sgr0
    fi
else
    tput bold; echo " "
    tput setaf 1; echo " Sorry, Your Machine doesn't meet the minimum requirements "
    tput sgr0; echo " "
fi
