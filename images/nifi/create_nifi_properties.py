#!/usr/bin/python

import os
import sys
from pprint import pprint

if len(sys.argv) != 2:
    print("Usage %s [FILE]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

BASE_KEY='nifi.'

keys = os.environ.keys()

DEFAULTS={
    'nifi.flow.configuration.file': '/var/lib/nifi/flow.xml.gz',
    'nifi.flow.configuration.json.file': '/var/lib/nifi/flow.json.gz',
    'nifi.flow.configuration.archive.dir': '/var/lib/nifi/flow-archive',
    'nifi.authorizer.configuration.file': '/opt/nifi/conf/authorizers.xml',
    'nifi.login.identity.provider.configuration.file': '/opt/nifi/conf/login-identity-providers.xml',
    'nifi.templates.directory': '/etc/nifi/templates',
    'nifi.nar.library.directory': '/opt/nifi/lib',
    'nifi.nar.library.autoload.directory': '/opt/nifi/extensions',
    'nifi.nar.working.directory': '/var/lib/nifi/work/nar',
    'nifi.documentation.working.directory': '/var/lib/nifi/work/docs/components',
    'nifi.state.management.configuration.file': '/opt/nifi/conf/state-management.xml',
    'nifi.database.directory': '/var/lib/nifi/database_repository',
    'nifi.flowfile.repository.directory': '/var/lib/nifi/flowfile_repository',
    'nifi.content.repository.directory.default': '/var/lib/nifi/content_repository',
    'nifi.provenance.repository.directory.default': '/var/lib/nifi/provenance_repository',
    'nifi.status.repository.questdb.persist.location': '/var/lib/nifi/status_repository',
    'nifi.web.jetty.working.directory': '/var/lib/nifi/work/jetty',
    'nifi.security.keystore': '/etc/nifi/pki/keystore.p12',
    'nifi.security.truststore': '/etc/nifi/pki/truststore.p12',
    'nifi.diagnostics.on.shutdown.directory': '/var/lib/nifi/diagnostics',
    'nifi.web.http.host': '0.0.0.0',
    'nifi.web.http.port': '8080',
    'nifi.web.https.host':'0.0.0.0',
    'nifi.web.https.port': '',
    'nifi.remote.input.secure': 'false',
}


config={}
with open('/opt/nifi/conf.default/nifi.properties') as origconf:
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
 
with open(sys.argv[1], 'w') as f:
    for k,v in config.items():
        line = '%s=%s' % (k,v)
        print(line)
        f.write(line + '\n')
