#!/usr/bin/python

import os
import sys
from pprint import pprint

if len(sys.argv) != 2:
    print("Usage %s [FILE]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

BASE_KEY='blacklist.'

keys = os.environ.keys()

conf = {}

for k in keys:
    if k.startswith(BASE_KEY):
        setting = '.'.join(k[len(BASE_KEY):].lower().split('.'))
        conf[setting] = ''

with open(sys.argv[1], 'w') as f:
    for setting in conf.keys():
        val = "%s" % (setting)
        print(val)
        f.write(val + '\n')
