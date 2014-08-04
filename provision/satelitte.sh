rabbitmqadmin -q declare exchange name=milery type=direct
rabbitmqadmin -q declare exchange name=milery.inbox type=direct
rabbitmqadmin -q declare exchange name=milery.outbox type=fanout

rabbitmqadmin -q declare queue name=milery
rabbitmqadmin -q declare queue name=milery.outbox

rabbitmqadmin -q declare binding \
    source=milery \
    destination=milery destination_type=queue

rabbitmqadmin -q declare binding \
    source=milery.inbox \
    destination=milery destination_type=queue \
    routing_key=$1

rabbitmqadmin -q declare binding \
    source=milery.outbox \
    destination=milery.outbox destination_type=queue

rabbitmqadmin -q declare binding \
    source=milery.outbox \
    destination=milery.inbox destination_type=exchange
    routing_key=$1

rabbitmqctl -q set_parameter shovel mothership \
    '$(cat /vagrant/conf/satelitte.json)'
