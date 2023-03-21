#!/usr/bin/python

import os
import sys
from pprint import pprint

if len(sys.argv) != 2:
    print("Usage %s [FILE]" % sys.argv[0], file=sys.stderr)
    sys.exit(1)

BASE_KEY='log4j.'

keys = os.environ.keys()

conf = {
    'log4j.rootLogger': 'INFO, stdout, file',
    'log4j.appender.stdout': 'org.apache.log4j.ConsoleAppender',
    'log4j.appender.stdout.layout': 'org.apache.log4j.PatternLayout',
    'log4j.appender.stdout.layout.ConversionPattern': r'[%d] %p %m (%c:%L)%n',
    'log4j.logger.kafka': 'ERROR, stdout',
    'log4j.logger.org.apache.zookeeper': 'ERROR, stdout',
    'log4j.logger.org.apache.kafka': 'ERROR, stdout',
    'log4j.additivity.kafka.server': 'false',
    'log4j.appender.file': 'org.apache.log4j.RollingFileAppender',
    'log4j.appender.file.maxBackupIndex': '10',
    'log4j.appender.file.maxFileSize': '100MB',
    'log4j.appender.file.File': '${schema-registry.log.dir}/schema-registry.log',
    'log4j.appender.file.layout': 'org.apache.log4j.PatternLayout',
    'log4j.appender.file.layout.ConversionPattern': r'[%d] %p %m (%c)%n'
}

for k in keys:
    if k.startswith(BASE_KEY):
        setting = '.'.join(k.split('.'))
        conf[setting] = os.environ[k]

with open(sys.argv[1], 'w') as f:
    for setting, value in conf.items():
        val = "%s=%s" % (setting, value)
        print(val)
        f.write(val + '\n')
