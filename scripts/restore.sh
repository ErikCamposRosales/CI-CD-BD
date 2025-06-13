#!/bin/bash

BACKUP_FILE=$1

if [ -z "$BACKUP_FILE" ]; then
  echo " Debes pasar el nombre del archivo de respaldo como argumento."
  echo " Ejemplo: ./restore.sh backups/backup-2025-06-13_09-40.sql"
  exit 1
fi

echo " Restaurando backup en el master..."
docker exec -i mysql-master mysql -uroot -padmin mydatabase < "$BACKUP_FILE"

echo " Restauración completada."
