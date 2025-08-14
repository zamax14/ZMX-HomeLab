#!/bin/bash
set -e

# Script para crear múltiples bases de datos en PostgreSQL
# Usado por docker-entrypoint-initdb.d

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Crear base de datos para Wiki.js
    CREATE DATABASE $WIKIJS_DB;
    GRANT ALL PRIVILEGES ON DATABASE $WIKIJS_DB TO $POSTGRES_USER;
    
    -- Crear base de datos para Nextcloud
    CREATE DATABASE $NEXTCLOUD_DB;
    GRANT ALL PRIVILEGES ON DATABASE $NEXTCLOUD_DB TO $POSTGRES_USER;
    
    -- Mostrar bases de datos creadas
    \l
EOSQL

echo "✅ Bases de datos creadas exitosamente:"
echo "   - $POSTGRES_DB (principal)"
echo "   - $WIKIJS_DB (Wiki.js)"
echo "   - $NEXTCLOUD_DB (Nextcloud)"
