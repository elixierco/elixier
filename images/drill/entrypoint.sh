#!/bin/bash

set -x

DRILL_CONF=${DRILL_CONF:-/etc/drill}

DRILL_SITE=${DRILL_SITE:-/var/lib/drill}

cp ${DRILL_CONF}/* ${DRILL_SITE}

/opt/drill/bin/drillbit.sh --site ${DRILL_SITE} "$@" 

sleep 120
