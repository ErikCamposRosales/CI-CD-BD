#!/bin/bash

DATE=$(date +%F_%H-%M)
BACKUP_DIR="./backups"
mkdir -p $BACKUP_DIR

echo " Haciendo respaldo del master..."
docker exec mysql-master sh -c 'exec mysqldump -uroot -padmin mydatabase' > $BACKUP_DIR/backup-$DATE.sql

echo " Backup guardado como $BACKUP_DIR/backup-$DATE.sql"
