#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE ruby_blog_test;
    CREATE DATABASE ruby_blog_production;
    GRANT ALL PRIVILEGES ON DATABASE ruby_blog_development TO $POSTGRES_USER;
    GRANT ALL PRIVILEGES ON DATABASE ruby_blog_test TO $POSTGRES_USER;
    GRANT ALL PRIVILEGES ON DATABASE ruby_blog_production TO $POSTGRES_USER;
EOSQL