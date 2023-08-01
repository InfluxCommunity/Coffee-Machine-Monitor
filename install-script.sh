#!/bin/sh
# Installing docker
sudo apt-get update && sudo apt-get upgrade -y
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker ${USER}

#Installing docker-compose
sudo apt-get install -y libffi-dev libssl-dev
sudo pip3 install docker-compose
sudo systemctl enable docker

# influxdata-archive_compat.key GPG fingerprint:
#     9D53 9D90 D332 8DC7 D6C8 D3B9 D8FF 8E1F 7DF8 B07E
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

sudo usermod -aG docker $USER

# start containers
sudo docker compose up -d

# setup influx CLI
sudo apt-get update && sudo apt-get install influxdb2-cli
influx config create \
  --config-name demo \
  --host-url http://localhost:8086 \
  --org influxdata \
  --token edge \
  --active

