#!/usr/bin/python

import os
import sys
from pprint import pprint

if len(sys.argv) != 2:
    print("Usage %s [FILE]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

BASE_KEY='livy.'

keys = os.environ.keys()

conf = {}

for k in keys:
    if k.startswith(BASE_KEY):
        setting = k
        conf[setting] = os.environ[k]

with open(sys.argv[1], 'w') as f:
    for setting, value in conf.items():
        val = "%s=%s" % (setting, value)
        print(val)
        f.write(val + '\n')
