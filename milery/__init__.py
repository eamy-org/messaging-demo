from celery import Celery

app = Celery()
app.config_from_object('milery.celeryconfig')

from .tasks import *
