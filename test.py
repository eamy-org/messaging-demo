import os
import time
import requests

NODE_NAME = 'iron'
OUTPUT_URL = 'http://192.168.33.10:4001/v2/keys/output'

os.environ['MILERY_NODE_NAME'] = NODE_NAME
os.environ['MILERY_BROKER'] = '192.168.33.11'

from milery.tasks import ping, here

requests.delete(OUTPUT_URL + '?recursive=true')


def msg(payload, dest, reply_to=None):
    if not reply_to:
        reply_to = NODE_NAME
    return ('{} to {} reply to {}'.format(payload, dest, reply_to), reply_to)

here.delay('0 to local ' + NODE_NAME)
ping.apply_async(msg('1', 'iron'), routing_key='iron')
ping.apply_async(msg('2', 'gold'), routing_key='gold')
ping.apply_async(msg('3', 'zinc'), routing_key='zinc')
ping.apply_async(msg('4', 'gold', 'zinc'), routing_key='gold')

def display_results(nodes):
    def sortByCreated(item):
        return item['createdIndex']
    for node in sorted(nodes, key=sortByCreated):
        print node['value']

while True:
    output = requests.get(OUTPUT_URL).json()
    nodes = output.get('node', {}).get('nodes', [])
    if len(nodes) == 9:
        display_results(nodes)
        break
    time.sleep(1)
