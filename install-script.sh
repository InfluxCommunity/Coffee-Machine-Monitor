#!/bin/sh
# Installing docker
sudo apt-get update && sudo apt-get upgrade -y
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker ${USER}

#Installing docker-compose
sudo apt-get install -y libffi-dev libssl-dev
sudo pip3 install docker-compose
sudo systemctl enable docker

# influxdb.key GPG Fingerprint: 05CE15085FC09D18E99EFB22684A14CF2582E0C5
wget -q https://repos.influxdata.com/influxdb.key
echo '23a1c8836f0afc5ed24e0486339d7cc8f6790b83886c4c96995b88a061c5bb5d influxdb.key' | sha256sum -c && cat influxdb.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdb.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

sudo usermod -aG docker $USER

# start containers
sudo docker-compose up -d

# setup influx CLI
sudo apt-get update && sudo apt-get install influxdb2-cli
influx config create \
  --config-name demo \
  --host-url http://localhost:8086 \
  --org influxdata \
  --token edge \
  --active

