#!/bin/bash

set -x
set -e

usage() {
  echo "usage: $0 DBTYPE..." >&2
}

waitfor() {
  retries=$1
  interval=$2
  check_cmd=$3

  until [ $retries -eq 0 ] || $check_cmd; do
    echo >&2 "waiting for $check_cmd..."
    sleep $interval
    retries=$(expr $retries - 1)
  done

  if [ $retries -eq 0 ]; then
    echo "wait for $check_cmd timeout"
    exit 2
  fi
}

if test "$#" -lt 1; then
  usage
  exit 2
fi
DBTYPE=$1

echo $DBTYPE

case $DBTYPE in
PostgreSQL)
  PG_CLUSTER=main
  values=(`pg_lsclusters -h|awk '{print $1, $3, $7}'|tr '\n' '\ '`)
  for i in 0; do
    PG_VERSION=${values[i]}    
    PG_PORT=${values[i+1]}
    PG_LOG=${values[i+2]}
    echo "PG_VERSION $PG_VERSION"
    echo "PG_PORT $PG_PORT"
    echo "export PATH=$PATH:/usr/lib/postgresql/$PG_VERSION/bin">> ~/.bashrc
    cd /var/lib/postgresql
    echo "host all all samenet md5" >>/etc/postgresql/$PG_VERSION/$PG_CLUSTER/pg_hba.conf
    cat >/etc/postgresql/$PG_VERSION/$PG_CLUSTER/conf.d/standbymp.conf <<EOF
listen_addresses = '*'
EOF
    pg_ctlcluster $PG_VERSION $PG_CLUSTER start
    waitfor 20 1 "pg_isready -p $PG_PORT"
    psql -p $PG_PORT <<EOF
      ALTER USER postgres PASSWORD 'pg';
EOF
  tail -f $PG_LOG
  done
  ;;
esac

