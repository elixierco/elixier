#!/usr/bin/python

import os
import sys
from pprint import pprint

if len(sys.argv) != 2:
    print("Usage %s [FILE]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

BASE_KEY='zookeeper.'

keys = os.environ.keys()

DEFAULTS={
    'tickTime': '2000',
    'dataDir': '/zkdata',
    'clientPort': '2181',
    'initLimit': '5',
    'syncLimit': '2',
}


config={}
with open('/opt/apache/zookeeper/conf/zoo_sample.cfg') as origconf:
    for l in origconf:
        l = l.strip()
        if not l:
            continue
        if l.startswith('#'):
            continue
        conf = l.split('#')[0]
        vals = conf.split('=')
        key = vals[0]
        value = '='.join(vals[1:])
        config[key] = value

for k, v in DEFAULTS.items():
    config[k] = v

for k in os.environ.keys():
    if k.startswith(BASE_KEY):
        config[k] = os.environ[k]

replicas = int(os.environ.get('ZOOKEEPER_REPLICAS', '1'))
pod_name = os.environ.get('K8S_POD_NAME', 'node-0')
pod_basename = '-'.join(pod_name.split('-')[:-1])
pod_id = int(pod_name.split('-')[-1]) + 1

for i in range(replicas):
    config['server.%s' % (i+1)]='%s-%s:2888:3888' % (pod_basename, i)

with open(os.path.join(config['dataDir'], 'myid'), 'w') as f:
    f.write(str(pod_id))

with open(sys.argv[1], 'w') as f:
    for k,v in config.items():
        line = '%s=%s' % (k,v)
        print(line)
        f.write(line + '\n')
