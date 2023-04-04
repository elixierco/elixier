#!/usr/bin/python

import os
import sys
from pprint import pprint
import re

pGB = re.compile(r'^\d+GB$')
pMB = re.compile(r'^\d+MB$')
pkB = re.compile(r'^\d+kB$')
pInt = re.compile(r'^\d+$')

if len(sys.argv) != 2:
    print("Usage %s [FILE]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

BASE_KEY='pgsql.'

keys = os.environ.keys()

DEFAULTS={
    'datestyle': 'iso, mdy',
    'default_text_search_config': 'pg_catalog.english',
    'log_timezone': 'Etc/UTC',
    'max_wal_size': '1GB',
    'min_wal_size': '80MB',
    'timezone': 'Etc/UTC',
}


config = {}
for k, v in DEFAULTS.items():
    config[k] = v

for k in os.environ.keys():
    if k.startswith(BASE_KEY):
        key = k[len(BASE_KEY):]
        config[key] = os.environ[k]
 
with open(sys.argv[1], 'w') as f:
    for k, v in config.items():
        if not (pGB.match(v) or pMB.match(v) or pkB.match(v)) and not pInt.match(v):
                v = "'%s'" % v
        line = '%s = %s' % (k,v)
        print(line)
        f.write(line + '\n')
