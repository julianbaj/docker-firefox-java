# Firefox over VNC
#
# VERSION               0.1
# DOCKER-VERSION        0.2

from	f69m/ubuntu32:16.04

# make sure the package repository is up to date
run	echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" > /etc/apt/sources.list
run	apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
run	apt-get install -y x11vnc xvfb openbox 

# Install the specific tzdata-java we need
run     apt-get -y install wget
run     wget --no-check-certificate http://archive.ubuntu.com/ubuntu/pool/main/t/tzdata/tzdata_2020a-0ubuntu0.16.04_all.deb
run     dpkg -i tzdata_2020a-0ubuntu0.16.04_all.deb

# Install Firefox and Java Plugins
run     apt-get install -y firefox icedtea-8-plugin icedtea-netx openjdk-8-jre openjdk-8-jre-headless 
run	mkdir ~/.vnc

# Autostart firefox (might not be the best way to do it, but it does the trick)
run     bash -c 'echo "exec openbox-session &" >> ~/.xinitrc'
run	bash -c 'echo "firefox" >> ~/.xinitrc'
run     bash -c 'chmod 755 ~/.xinitrc'
