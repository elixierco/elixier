#!/usr/bin/python

import os
import sys
from pprint import pprint

if len(sys.argv) != 2:
    print("Usage %s [DIRECTORY]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

outdir = sys.argv[1]
if not os.path.exists(outdir):
    print("Directory %s not found" % outdir)
    sys.exit(1)
    
BASE_KEY='trino.catalog.'

keys = os.environ.keys()

catalogs = {}

for k in keys:
    if k.startswith(BASE_KEY):
        catalog = k[len(BASE_KEY):].lower().split('.')[0]
        setting = '.'.join(k[len(BASE_KEY):].lower().split('.')[1:])
        catalogs.setdefault(catalog, {})
        catalogs[catalog][setting] = os.environ[k]

for catalog in catalogs:
    with open("%s/%s.properties" % (outdir, catalog), 'w') as f:
        for setting, value in catalogs[catalog].items():
            val = '%s=%s' % (setting,value)
            print(val)
            f.write(val + '\n')      
