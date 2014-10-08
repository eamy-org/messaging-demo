ETCD_VERSION=v0.4.6
curl -sLO https://github.com/coreos/etcd/releases/download/$ETCD_VERSION/etcd-$ETCD_VERSION-linux-amd64.tar.gz
tar xf etcd-$ETCD_VERSION-linux-amd64.tar.gz
mv etcd-$ETCD_VERSION-linux-amd64 /opt/etcd
rm etcd-$ETCD_VERSION-linux-amd64.tar.gz
mkdir /var/lib/etcd
mkdir /etc/etcd

cat > /etc/etcd/etcd.conf << EOF
addr = "$1:4001"
bind_addr = "0.0.0.0:4001"
data_dir = "/var/lib/etcd"
peers = [ "zinc:7001", "iron:7001", "gold:7001" ]
name = "$1"
max_retry_attempts = 10

[peer]
addr = "$1:7001"
bind_addr = "0.0.0.0:7001"
EOF

cp -v /vagrant/provision/etcd-daemon.sh /etc/init.d/etcd
chmod +x /etc/init.d/etcd

# Some node needs to be a leader without any peers
if [ "$1" == "zinc" ]; then
    sed -i /^peers/d /etc/etcd/etcd.conf
    
fi

service etcd start
