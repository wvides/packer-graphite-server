#!/bin/bash
set -xe

# Installing node and git
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y gcc g++ make
sudo apt-get install -y nodejs 
sudo apt-get install -y git 

# Clonning and configuring statsd
cd /opt/
sudo git clone git://github.com/etsy/statsd.git
touch /opt/statsd/localConfig.js
echo "{
  graphitePort: 2003,
  graphiteHost: '127.0.0.1',
  port:8125
}" >> /opt/statsd/localConfig.js

# Restarting carbon-cache service and starting stat
systemctl restart carbon-cache
cd /opt/statsd
node ./stats.js ./localConfig.js &