rabbitmqadmin -q declare exchange name=milery type=direct
rabbitmqadmin -q declare exchange name=milery.inbox type=direct
rabbitmqadmin -q declare exchange name=milery.outbox type=fanout

rabbitmqadmin -q declare queue name=milery
rabbitmqadmin -q declare queue name=milery.iron
rabbitmqadmin -q declare queue name=milery.gold

rabbitmqadmin -q declare binding \
    source=milery \
    destination=milery destination_type=queue

rabbitmqadmin -q declare binding \
    source=milery.inbox \
    destination=milery destination_type=queue \
    routing_key=zinc

rabbitmqadmin -q declare binding \
    source=milery.inbox \
    destination=milery.iron destination_type=queue \
    routing_key=iron

rabbitmqadmin -q declare binding \
    source=milery.inbox \
    destination=milery.gold destination_type=queue \
    routing_key=gold

rabbitmqadmin -q declare binding \
    source=milery.outbox \
    destination=milery.inbox destination_type=exchange

rabbitmqctl -q set_parameter shovel iron \
    '$(cat /vagrant/conf/mothership/iron.json)'

rabbitmqctl -q set_parameter shovel gold \
    '$(cat /vagrant/conf/mothership/gold.json)'
