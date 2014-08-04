apt-get -qy install python-pip

pip install -U /vagrant/dist/milery*.tar.gz

mkdir -p /var/log/celery
export MILERY_OUTPUT=/vagrant/$1.log
export MILERY_NODE_NAME=$1
celery -A milery worker -Q milery \
    --detach --pidfile=/var/run/celeryd.pid \
    --loglevel=INFO --logfile=/var/log/celery/celery.log
