#!/usr/bin/env bash

# Se acontecer erro para tudo
set -e

# Locale compatível com UTF-8
locale-gen en_GB.utf8
update-locale LANG=en_GB.utf8 LC_ALL=en_GB.utf8
export LANG=en_GB.utf8
export LC_ALL=en_GB.utf8

# Atualiza os programas
apt-get update
apt-get upgrade -y

# Baixa o necessário
sudo apt-get install -y ruby2.3 libruby2.3 ruby2.3-dev \
                     libmagickwand-dev libxml2-dev libxslt1-dev nodejs \
                     apache2 apache2-dev build-essential git-core \
                     postgresql postgresql-contrib libpq-dev postgresql-server-dev-all \
                     libsasl2-dev imagemagick \
                     phantomjs
sudo gem2.3 install bundler

## Faz o bundle install
pushd /srv/projeto
sudo -u vagrant -H bundle install --retry=10 --jobs=2
# Cria um usuário e o banco de dados caso necessário
db_user_exists=`sudo -u postgres psql postgres -tAc "select 1 from pg_roles where rolname='vagrant'"`
if [ "$db_user_exists" != "1" ]; then
		sudo -u postgres createuser -s vagrant
		sudo -u vagrant createdb -E UTF-8 -O vagrant gislene
		sudo -u vagrant createdb -E UTF-8 -O vagrant osm_test
		# Adiciona a extensão btree_gist
		sudo -u vagrant psql -c "create extension btree_gist" gislene
		sudo -u vagrant psql -c "create extension btree_gist" osm_test
fi

# Compila e adiciona as outras extensões
pushd db/functions
sudo -u vagrant make
sudo -u vagrant psql gislene -c "CREATE OR REPLACE FUNCTION maptile_for_point(int8, int8, int4) RETURNS int4 AS '/srv/projeto/db/functions/libpgosm.so', 'maptile_for_point' LANGUAGE C STRICT"
sudo -u vagrant psql gislene -c "CREATE OR REPLACE FUNCTION tile_for_point(int4, int4) RETURNS int8 AS '/srv/projeto/db/functions/libpgosm.so', 'tile_for_point' LANGUAGE C STRICT"
sudo -u vagrant psql gislene -c "CREATE OR REPLACE FUNCTION xid_to_int4(xid) RETURNS int4 AS '/srv/projeto/db/functions/libpgosm.so', 'xid_to_int4' LANGUAGE C STRICT"
popd

# Copia as configurações padrão
if [ ! -f config/database.yml ]; then
		sudo -u vagrant cp config/example.database.yml config/database.yml
fi
if [ ! -f config/application.yml ]; then
		sudo -u vagrant cp config/example2.application.yml config/application.yml
fi

# Cria o esqueleto do banco de dados
sudo -u vagrant rake db:migrate

# Cria um usuário administrador padrão
rails runner -e development cria_admin.rb

popd


FILE="clonarGit.sh"

/bin/cat <<EOM >$FILE

git clone --depth=1 https://github.com/lindemberglta/CES29_Gislene
cd CES29_Gislene
cd projeto_padrao_OSM
bundle install

cd db/functions
make libpgosm.so
cd ../..

bundle exec rake db:create

psql -d gislene -c "create extension btree_gist"
psql -d gislene -c "CREATE FUNCTION maptile_for_point(int8, int8, int4) RETURNS int4 AS '`pwd`/db/functions/libpgosm', 'maptile_for_point' LANGUAGE C STRICT"
psql -d gislene -c "CREATE FUNCTION tile_for_point(int4, int4) RETURNS int8 AS '`pwd`/db/functions/libpgosm', 'tile_for_point' LANGUAGE C STRICT"
psql -d gislene -c "CREATE FUNCTION xid_to_int4(xid) RETURNS int4 AS '`pwd`/db/functions/libpgosm', 'xid_to_int4' LANGUAGE C STRICT"


# Copia as configurações padrão
if [ ! -f config/database.yml ]; then
		cp config/example.database.yml config/database.yml
fi
if [ ! -f config/application.yml ]; then
		cp config/example2.application.yml config/application.yml
fi

# Cria o esqueleto do banco de dados
bundle exec rake db:migrate

# Cria um usuário administrador padrão
rails runner -e development cria_admin.rb
EOM