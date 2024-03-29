####################################################################
## Author: "Tech With NC"
#
## Date Created: 1/Feb/2023
## Last Modified: 1/Jun/2023
# 
## Description.
## How to install node_exporter as service on ubuntu OS.
####################################################################

# Creating user for node_exporter.
sudo useradd --no-create-home --shell /bin/false node_exporter
# Download node_exporter. 
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
# Extract downloaded file.
sudo tar xvf node_exporter-1.5.0.linux-amd64.tar.gz
# Copy executable file.
sudo cp node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin
# Set user and group ownership to node_exporter user
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
# Delete downloaded file
sudo rm -rf node_exporter-1.5.0.linux-amd64.tar.gz node_exporter-1.5.0.linux-amd64
# Create service for node_exporter
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Need to add node_export ip address to prometheus yaml file
# - job_name: 'node_exporter_metrics'
#   scrape_interval: 5s
#   static_configs:
#     - targets: ['YOUR-IP-ADD:9100']