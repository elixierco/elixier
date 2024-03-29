#!/bin/bash -x

PRESTO_CONF_DIR=/etc/presto/

cat <<EOF > $PRESTO_CONF_DIR/node.properties
node.id=$HOSTNAME
node.data-dir=$PRESTO_DATA_DIR
node.environment=presto
EOF


if [ "$1" == "shell" ];then
    /bin/bash
elif [ "$1" == "initcatalog" ];then
    python3 /opt/presto/bin/create_catalog_config.py $PRESTO_CONF_DIR/catalog
else
    python3 /opt/presto/bin/launcher.py "$@"
fi
