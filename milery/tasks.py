from __future__ import print_function
from datetime import datetime
from celery import current_app as app
from celery.utils.log import get_task_logger

OUTPUT_FILE_NAME = app.conf.MILERY_OUTPUT
NODE_NAME = app.conf.MILERY_NODE_NAME
log = get_task_logger(__name__)


@app.task()
def ping(message, reply_to):
    _write_output('ping', message)
    pong.apply_async((message,), routing_key=reply_to)


@app.task()
def pong(message):
    _write_output('pong', message)


@app.task(ignore_result=False)
def here(message):
    _write_output('here', message)
    return message


def _write_output(task, message):
    output = '[{} {}] {}: "{}"'.format(
        datetime.now().strftime('%H:%M:%S'), task, NODE_NAME, message)
    log.info(output)
    with open(OUTPUT_FILE_NAME, 'a') as output_file:
        print(output, file=output_file)
