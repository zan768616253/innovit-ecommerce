#!/bin/bash
set -e
set -x

RETRIES=20
INTERVAL=1

PG_CLUSTER=main

check_cmd() {
  pg_isready -p $WAIT_PORT
}

waitfor() {
  retries=$1

  until [ $retries -eq 0 ] || check_cmd; do
    echo >&2 "waiting for PostgreSQL..."
    sleep $INTERVAL
    ((retries = retries - 1))
  done

  if [ $retries -eq 0 ]; then
    return 1
  fi
}

createTestDB(){
  PG_VERSION=$1
  WAIT_PORT=$2
  pg_ctlcluster $PG_VERSION $PG_CLUSTER start
  waitfor $RETRIES

  psql -p $WAIT_PORT -w -f /var/lib/postgresql/scripts/createTestDB.sql

  pg_ctlcluster $PG_VERSION $PG_CLUSTER stop
}

values=(`pg_lsclusters -h|awk -v ver=1 -v port=3 '{print $ver, $port}'`)
for i in 0; do
  createTestDB ${values[i]} ${values[i+1]}
done