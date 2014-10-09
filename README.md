messaging-demo
==============

Demo network using RabbitMQ Shovel plugin

## Run virtual machines

```
$ vagrant up --provider virtualbox
```

Wait until vagrant will complete construction.

## Prepare an environment for the test script

```
$ virtualenv -p python2.7 venv
$ . venv/bin/activate
$ pip install requests celery
```

## Run the test script

```
$ python test.py
```

The output will look like the sample below:

```
[here] iron: "0 to local iron"
[ping] zinc: "3 to zinc reply to iron"
[ping] gold: "2 to gold reply to iron"
[ping] iron: "1 to iron reply to iron"
[ping] gold: "4 to gold reply to zinc"
[pong] zinc: "4 to gold reply to zinc"
[pong] iron: "3 to zinc reply to iron"
[pong] iron: "2 to gold reply to iron"
[pong] iron: "1 to iron reply to iron"
```

BUGS: etcd daemon do not start when the system reboot.
Do not run `vagrant reload`.
