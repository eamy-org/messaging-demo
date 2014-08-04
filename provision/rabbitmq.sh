echo "deb http://www.rabbitmq.com/debian/ testing main" \
    | tee /etc/apt/sources.list.d/rabbitmq.list
curl -sO http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc
rm rabbitmq-signing-key-public.asc

apt-get -qq update
apt-get -qy install rabbitmq-server

rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_shovel
rabbitmq-plugins enable rabbitmq_shovel_management

rabbitmqctl -q add_user tonyg changeit
rabbitmqctl -q set_permissions -p / tonyg ".*" ".*" ".*"
rabbitmqctl -q set_user_tags tonyg administrator

service rabbitmq-server restart

curl -sO http://localhost:15672/cli/rabbitmqadmin
mv rabbitmqadmin /usr/local/bin/
chmod +x /usr/local/bin/rabbitmqadmin
