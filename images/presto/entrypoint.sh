#!/bin/bash

PRESTO_CONF_DIR=/opt/presto/etc/

cat <<EOF > $PRESTO_CONF_DIR/node.properties
node.id=$HOSTNAME
node.data-dir=$PRESTO_DATA_DIR
node.environment=presto
EOF

python3 /opt/presto/bin/launcher.py "$@"
