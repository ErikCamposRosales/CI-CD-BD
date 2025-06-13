#!/bin/bash

TARGET_CONTAINER=$1

if [ -z "$TARGET_CONTAINER" ]; then
  echo " Debes especificar un contenedor destino."
  echo " Ejemplo: ./migrate.sh mysql-slave1"
  exit 1
fi

echo " Exportando desde el master..."
docker exec mysql-master sh -c 'exec mysqldump -uroot -padmin mydatabase' > tmp-migrate.sql

echo " Importando en $TARGET_CONTAINER..."
docker cp tmp-migrate.sql $TARGET_CONTAINER:/tmp/
docker exec $TARGET_CONTAINER mysql -uroot -padmin mydatabase < /tmp/tmp-migrate.sql

echo " Migración completada."
rm tmp-migrate.sql
