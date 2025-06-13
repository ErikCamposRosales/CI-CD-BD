#!/bin/bash

# Credenciales
USER="root"
PASS="admin"

echo " Esperando a que el master esté listo..."
sleep 20

# Obtener la posición del log binario del master
MASTER_STATUS=$(docker exec mysql-master mysql -u$USER -p$PASS -e "SHOW MASTER STATUS\G")
FILE=$(echo "$MASTER_STATUS" | grep File: | awk '{print $2}')
POS=$(echo "$MASTER_STATUS" | grep Position: | awk '{print $2}')

echo " Archivo de log: $FILE"
echo " Posición: $POS"

# Configurar replicación en mysql-slave1
for SLAVE in mysql-slave1 mysql-slave2; do
  echo " Configurando replicación en $SLAVE..."
  docker exec $SLAVE mysql -u$USER -p$PASS -e "STOP SLAVE;"
  docker exec $SLAVE mysql -u$USER -p$PASS -e "
    CHANGE MASTER TO
      MASTER_HOST='mysql-master',
      MASTER_USER='replication_user',
      MASTER_PASSWORD='admin',
      MASTER_LOG_FILE='$FILE',
      MASTER_LOG_POS=$POS,
      GET_MASTER_PUBLIC_KEY = 1;
    START SLAVE;
  "
  docker exec $SLAVE mysql -u$USER -p$PASS -e "SHOW SLAVE STATUS\G" | grep -E 'Slave_IO_Running|Slave_SQL_Running'
done
