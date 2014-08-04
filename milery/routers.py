class PrefixRouter(object):

    def __init__(self, exchange, task_prefix):
        self.task_prefix = task_prefix
        self.route = {'exchange': exchange, 'exchange_type': 'fanout'}

    def route_for_task(self, task, *args, **kwargs):
        if task.startswith(self.task_prefix):
            return self.route
