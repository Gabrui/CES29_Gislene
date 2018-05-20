# Projeto com Padrão OSM (Open Street Map)

Utilizar a máquina virtual VirtualBox com o gerenciador Vagrant para rodar o servidor.
https://www.vagrantup.com/downloads.html
https://www.virtualbox.org/wiki/Downloads

Recomendo fortemente instalar pelo instalador do site e não pelo apt-get, pois o meu Virtual Box deu problema, só funcionou com o do site.
```
sudo apt-get install vagrant
sudo apt-get install virtualbox
```

De posse dos programas acima instalados e rodando corretamente, vá na pasta do projeto e inicie a máquina virtual:

```
vagrant up
```
OBS: O virtual box reclamou do secure boot no meu PC, tive que desabilitá-lo. Um comando que ajuda a configurar a VirtualBox em caso de problema é o sudo /sbin/vboxconfig.
OBS2: No linux não coloque essa pasta em um sistema de arquivos que não é linux, perdi tempo com isso.

Esse comando irá baixar a imagem de uma nova máquina virtual e instalar todas as dependências (banco de dados) nela, isso pode demorar um pouco pela primeira vez.

Assim que a instalação for concluída, você pode logar na máquina virtual por meio do comando
```
vagrant ssh
```

Dentro da máquina virtual existe uma pasta compartilhada do projeto, vá para ela:
```
cd /srv/projeto/
```

Para rodar o servidor, use o comando:
```
rails server --binding=0.0.0.0
```

Qualquer modificação no código da pasta do projeto refletirá na máquina virtual, que usa a pasta compartilhada.

Ativação do usuário criado sem serviço de e-mail:
```
bundle exec rails console
user = User.find_by_display_name("My New User Name")
user.status = "active"
user.save!
quit
```

Após isso, para ativar a autenticação para execução, entre nas configurações do seu usuário, configurações oauth, registrar aplicação, nome: "Local iD" e url: "http://localhost:3000", marque todas as alternativas, registre, copie o consumer key e copie para o arquivo config/application.yml.

```
id_key: suaKeyAqui
```

Para rodar os testes:
```
cd /srv/projeto/
rake test
```

## Outros Comandos

You can run the existing test suite with:

```
bundle exec rake test
```

```
bundle exec rake db:migrate
```

You can generate test coverage stats with:

```
sudo gem install rcov
rcov -x gems test/*/*.rb
```

To generate the HTML documentation of the API/rails code, run the command

```
rake doc:app
```

Permissão de admin:

```
$ bundle exec rails console
>> user = User.find_by_display_name("My New User Name")
=> #[ ... ]
>> user.roles.create(:role => "administrator", :granter_id => user.id)
=> #[ ... ]
>> user.roles.create(:role => "moderator", :granter_id => user.id)
=> #[ ... ]
>> user.save!
=> true
>> quit
```
Rails has its own log.  To inspect the log, do this:

```
tail -f log/development.log
```

## Sobre

O projeto OSM é baseado na aplicação que roda o site do [OpenStreetMap](https://www.openstreetmap.org), The Rails Port, de código aberto ([GNU General Public License 2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)).

[![Build Status](https://travis-ci.org/openstreetmap/openstreetmap-website.svg?branch=master)](https://travis-ci.org/openstreetmap/openstreetmap-website)
[![Coverage Status](https://coveralls.io/repos/openstreetmap/openstreetmap-website/badge.svg?branch=master)](https://coveralls.io/r/openstreetmap/openstreetmap-website?branch=master)

Assim tem-se as seguintes aplicações já prontas:

* The web site, including user accounts, diary entries, user-to-user messaging
* The XML-based editing [API](https://wiki.openstreetmap.org/wiki/API_v0.6)
* The integrated versions of the [iD](https://wiki.openstreetmap.org/wiki/ID) editor
* The Browse pages - a web front-end to the OpenStreetMap data
* The GPX uploads, browsing and API.


# CES29_Gislene sem OSM (Back end)

## Configuração Inicial do projeto

O projeto é realizado em Ruby on Rails, sendo necessário o seu executável e algumas bibliotecas dependentes, além do gerenciador de configuração Bundler.

```
sudo apt-get install ruby2.3 libruby2.3 ruby2.3-dev libmagickwand-dev libxml2-dev libxslt1-dev nodejs
sudo gem2.3 install bundler
```

Asim após instalar o Gerenciador de Configurações, utilize-o para resolver as outras dependências, dentro do projeto:
```
bundle install
```

## Configuração Inicial do Banco de Dados

### Instalação do Postgres

Instale o postgres (versão maior ou igual a 9.6). No windows pode-se baixar os instaladores e seguir os passos de instalação.
```
sudo apt-get install postgresql postgresql-contrib libpq-dev
sudo apt-get install pgadmin3
```

Assim, quando for pedido para criar o usuário na instalação, escreva o nome do seu próprio usuário e aceite-o como super usuário.

```
sudo -u postgres createuser --interactive
```

Agora você tem um usuário no banco de dados que é o seu próprio.


### Atualização
Depois, já que eu configurei os arquivos Gemfile e database.yml, é necessário rodar apenas esses comandos para atualizar o banco de dados:
```
bundler install
rake db:setup
rake db:migrate
```
OBS: não sei se o database.yml vai funcionar para windows, pois parece que o windows não tem domain sockets, então teria que usar um host: localhost

### Visualização do banco de dados

Instale o visualizador pgAdmin3. No windows pode-se baixar os instaladores e seguir os passos de instalação.
```
sudo apt-get install pgadmin3
```

No windows já vem configurado, mas no linux será necessário criar a conexão com o servidor:
Vá em Add Server, coloque o nome (name) qualquer, host /var/run/postgresql, port 5432, maintenance db postgres, username o seu próprio.

# Instalação Manual

Usar o Ubuntu 16.04 com os programas:

```
sudo apt-get install ruby2.3 libruby2.3 ruby2.3-dev \
                     libmagickwand-dev libxml2-dev libxslt1-dev nodejs \
                     apache2 apache2-dev build-essential git-core \
                     postgresql postgresql-contrib libpq-dev postgresql-server-dev-all \
                     libsasl2-dev imagemagick libffi-dev
sudo gem2.3 install bundler
```

O [Bundler](http://gembundler.com/) é utilizado para gerir as dependências de código ruby.

```
bundle install
```

É preciso configurar a  `config/application.yml`.

```
cp config/example.application.yml config/application.yml
```

E também a 

```
cp config/example.database.yml config/database.yml
```

### Criar a conta no banco de dados com o seu nome de usuário

Um PostgreSQL role, precisa ser superusuário

```
sudo -u postgres createuser --interactive
```


### Criar os bancos de dados

Execute o script

```
bundle exec rake db:create
```

### PostgreSQL Btree-gist

Precisa habilitar a extensão `btree-gist`

```
psql -d gislene -c "CREATE EXTENSION btree_gist"
```

### PostgreSQL Funções especiais

Compile as funções

```
cd db/functions
make libpgosm.so
cd ../..
```

E instale-as

```
psql -d gislene -c "CREATE FUNCTION maptile_for_point(int8, int8, int4) RETURNS int4 AS '`pwd`/db/functions/libpgosm', 'maptile_for_point' LANGUAGE C STRICT"
psql -d gislene -c "CREATE FUNCTION tile_for_point(int4, int4) RETURNS int8 AS '`pwd`/db/functions/libpgosm', 'tile_for_point' LANGUAGE C STRICT"
psql -d gislene -c "CREATE FUNCTION xid_to_int4(xid) RETURNS int4 AS '`pwd`/db/functions/libpgosm', 'xid_to_int4' LANGUAGE C STRICT"
```

### Estrutura do banco de dados

Crie as estruturas

```
bundle exec rake db:migrate
```

## Rode os testes

Para verificar que está tudo certo

```
bundle exec rake test:db
```

### Execute o servidor localmente

```
bundle exec rails server
```
