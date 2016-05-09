#!/bin/bash
# This script is designed for use as the entrypoint on a 
# docker image based on mongo and specifically for backing
# up all mongo databases from a mongo container running
# on the same host.
#
# The script relies on the fact that the container for this
# image has been created with a link to the mongo container and
# therefore contains a hosts file entry for mongo_svr.
#
# It also assumes that the container has been created with
# a volume for /data/mongodb_bkp mapping to an external
# directory on the host by the same name, e.g.
#
# docker create --link mongo:mongo_svr -it --name="mongo_bkp_svr" -v /data/mongodb_bkp:/data/mongodb_bkp mongo_bkp_svr
#

MONGODUMP_EXE_PATH="/usr/bin/mongodump"
MONGO_HOST="mongo_svr"
MONGO_PORT="27017"
BACKUP_PATH="/data/mongodb_bkp/dump"
TAR_PATH="/data/mongodb_bkp/"
TIMESTAMP=`date +%F-%H%M`

echo "Docker Backup server is alive"
echo "Connecting to the mongo container and dumping files"
$MONGODUMP_EXE_PATH -h $MONGO_HOST:$MONGO_PORT -o $BACKUP_PATH --oplog

echo "Consolidating and compressing backup file"
tar czf $TAR_PATH$MONGO_HOST-$TIMESTAMP.tar.gz $BACKUP_PATH

echo "Removing temporary backup files"
rm -rf $BACKUP_PATH/*
exit 0

