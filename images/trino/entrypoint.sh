#!/bin/bash -x

TRINO_CONF_DIR=/etc/trino/

cat <<EOF > $TRINO_CONF_DIR/node.properties
node.id=$HOSTNAME
node.data-dir=$TRINO_DATA_DIR
node.environment=trino
EOF


if [ "$1" == "shell" ];then
    /bin/bash
elif [ "$1" == "initcatalog" ];then
    python3 /opt/trino/bin/create_catalog_config.py $TRINO_CONF_DIR/catalog
else
    python3 /opt/trino/bin/launcher.py "$@"
fi
