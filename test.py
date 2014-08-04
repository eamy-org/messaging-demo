import os
import random
import string

NODE_NAME = 'iron'

os.environ['MILERY_NODE_NAME'] = NODE_NAME
os.environ['MILERY_BROKER'] = '192.168.33.11'

from milery.tasks import ping, here

def msg():
    a = ''.join(random.sample(string.ascii_lowercase, 3))
    b = ''.join(random.sample(string.ascii_lowercase, 5))
    return a + ' ' + b

here.delay(msg())

ping.apply_async((msg(), NODE_NAME), routing_key='iron')
ping.apply_async((msg(), NODE_NAME), routing_key='gold')
ping.apply_async((msg(), NODE_NAME), routing_key='zinc')

ping.apply_async((msg(), 'zinc'), routing_key='iron')
