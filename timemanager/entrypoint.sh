#!/bin/bash

while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER

do
  echo "user: $PGUSER password: $PGPASSWORD db: $PGDATABASE port: $PGPORT host: $PGHOST"

  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.

if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then

  echo "Database $PGDATABASE does not exist. Creating..."

  mix ecto.setup

  echo "Database $PGDATABASE created."
else
    echo "Database $PGDATABASE exists. Starting reset..."

    mix ecto.reset
    mix ecto.setup

    echo "Database $PGDATABASE reset."
fi

exec psql -U postgres -d timemanager_dev -f timemanager_dev.sql

exec mix phx.server
