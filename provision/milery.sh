# see python-librabbitmq issue:
# https://bugs.launchpad.net/ubuntu/+source/python-librabbitmq/+bug/1353269
# apt-get -qy install python-pip python-requests __python-celery__

apt-get -qy install python-pip python-requests
pip install celery

pip install -U /vagrant/dist/milery*.tar.gz --no-dependencies

mkdir -p /var/log/celery
export MILERY_OUTPUT=http://localhost:4001/v2/keys/output
export MILERY_NODE_NAME=$1
celery -A milery worker -Q milery \
    --detach --pidfile=/var/run/celeryd.pid \
    --loglevel=INFO --logfile=/var/log/celery/celery.log
