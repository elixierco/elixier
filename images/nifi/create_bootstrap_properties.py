#!/usr/bin/python

import os
import sys
from pprint import pprint

if len(sys.argv) != 2:
    print("Usage %s [FILE]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

BASE_KEY='bootstrap.'

keys = os.environ.keys()

DEFAULTS={
    'java': 'java',
    'run.as': '',
    'preserve.environment': 'false',
    'lib.dir': '/opt/nifi/lib',
    'conf.dir': '/opt/nifi/conf',
    'graceful.shutdown.seconds': '20',
    'java.arg.1': '-Dorg.apache.jasper.compiler.disablejsr199=true',
    'java.arg.2': '-Xms512m',
    'java.arg.3': '-Xmx512m',
    'java.arg.4': '-Djava.net.preferIPv4Stack=true',
    'java.arg.5': '-Dsun.net.http.allowRestrictedHeaders=true',
    'java.arg.6': '-Djava.protocol.handler.pkgs=sun.net.www.protocol',
    'java.arg.14': '-Djava.awt.headless=true',
    'nifi.bootstrap.sensitive.key': '',
    'java.arg.15': '-Djava.security.egd=file:/dev/urandom',
    'java.arg.16': '-Djavax.security.auth.useSubjectCredsOnly=true',
    'java.arg.17': '-Dzookeeper.admin.enableServer=false',
    'notification.services.file': './conf/bootstrap-notification-services.xml',
    'notification.max.attempts': '5',
    'java.arg.curator.supress.excessive.logs': '-Dcurator-log-only-first-connection-issue-as-error-level=true',
    'nifi.bootstrap.listen.port': '0',
}


config={}

for k, v in DEFAULTS.items():
    config[k] = v

for k in os.environ.keys():
    if k.startswith(BASE_KEY):
        key = k[len(BASE_KEY):]
        config[key] = os.environ[k]
 
with open(sys.argv[1], 'w') as f:
    for k,v in config.items():
        line = '%s=%s' % (k,v)
        print(line)
        f.write(line + '\n')
