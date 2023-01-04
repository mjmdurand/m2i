cd /etc/netplan
cp 50-cloud-init.yaml 51-cluster.yaml
nano 51-cluster.yaml
apt update
apt install -y zfsutils-linux linux-azure