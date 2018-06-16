# Projeto com Padrão OSM (Open Street Map)

Utilizar a máquina virtual VirtualBox com o gerenciador Vagrant para rodar o servidor.

https://www.vagrantup.com/downloads.html

https://www.virtualbox.org/wiki/Downloads

Para usuários Linux, é recomendável utilizar o instalador do site  para obter a versão mais recente, e não pelo apt-get.
```
sudo apt-get install vagrant
sudo apt-get install virtualbox
```
OBS: O virtual box reclamou do secure boot no meu PC, tive que desabilitá-lo. Um comando que ajuda a configurar a VirtualBox em caso de problema é o sudo /sbin/vboxconfig.

OBS2: No linux não coloque essa pasta em um sistema de arquivos que não é linux, perdi tempo com isso. Para poder ter pastas sincronizadas


De posse dos programas acima instalados e rodando corretamente, vá na pasta do projeto e inicie a máquina virtual. A maquina virtual tem uma pasta sincronizada com a pasta do projeto. Assim, arquivos modificados na pasta refletirá na máquina virtual. No Windows essa sincronização pode não funcionar, sendo necessário a edição dentro da própria máquina virtual.

No Windows caso o compartilhamento de pastas não funcione corretamente, é necessário executar o arquivo bash ClonarGit.sh na pasta /home/ubuntu. Esse script efetuará o download local do repositório e fará as inicializações necessárias. Assim o projeto deverá ser acessado apenas dentro da máquina virtual na pasta /home/ubuntu/CES29_Gislene/projeto_padrao_OSM.

```
cd /home/ubuntu
./ClonarGit.sh
```

```
vagrant up
```

Caso se esteja atrás de um proxy, é necessário configurá-lo na máquina virtual, para que a mesma possa acessar a internet para baixar os programas e as dependências necessárias. A ideia é declarar variáveis de ambiente com a autenticação para o proxy, instalar o plugin do Vagrant para lidar com o proxy e configurar mais variáveis de ambiente para serem utilizadas pelo plugin, que efetivamente coordenará o tráfego de rede da máquina virtual. Os comandos para os sistemas Linux são (lembrando de alterar o user, password, host e port do comando):

```
export http_proxy="http://user:password@host:port"
export https_proxy="http://user:password@host:port"
vagrant plugin install vagrant-proxyconf
```

E depois de instalado o plugin proxy:

```
export VAGRANT_HTTP_PROXY="http://user:password@host:port"
export VAGRANT_NO_PROXY="127.0.0.1"
vagrant up
```

Caso o ambiente seja Windows, a única diferença são nas variáveis de ambiente:

```
set http_proxy=http://user:password@host:port
set https_proxy=%http_proxy%
vagrant plugin install vagrant-proxyconf
```

E depois de instalado o plugin proxy:

```
set VAGRANT_HTTP_PROXY="%http_proxy%"
set VAGRANT_NO_PROXY="127.0.0.1"
vagrant up
```

A execução da máquina virtual, dentro da pasta do projeto que contém o Vagrantfile, se dá por meio do seguinte comando. As Figuras 3, 4, 5 e 6 ilustram a saída desse comando, responsável por instalar e configurar a máquina virtual, baixando todas as dependências. Esse comando irá baixar a imagem de uma nova máquina virtual e instalar todas as dependências (banco de dados) nela, isso pode demorar um pouco pela primeira vez.

```
vagrant up
```

Se houver algum problema durante a instalação, a máquina pode ser parada com o comando de parada, inicializada novamente, e reconfigurada com o comando vagrant provision, que executará novamente o script de configuração inicial.
```
vagrant halt
vagrant up
vagrant provision
```

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

Qualquer modificação no código da pasta do projeto refletirá na máquina virtual, que usa a pasta compartilhada (/srv/projeto).

O servidor pode ser acessado localmente pelo navegador no endereço localhost:3000, e o banco de dados pode ser acessado pela porta 5433, com usuário Vagrant sem senha.

É criado automaticamente uma conta de administrador com um aplicação OAuth para a autenticação da API. Esse código é executado automaticamente e pode ser visto no arquivo cria_admin.rb.


## Outros Comandos

Para rodar os testes existentes:

```
bundle exec rake test
```

Para atualizar o banco de dados depois de criar um novo model:

```
bundle exec rake db:migrate
```

Teste de cobertura estáticos:

```
sudo gem install rcov
rcov -x gems test/*/*.rb
```

Para gerar a documentação automática do código:

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

O Rails faz um log automático, pode ser visto em:

```
tail -f log/development.log
```


## Sobre

O projeto OSM é baseado na aplicação que roda o site do [OpenStreetMap](https://www.openstreetmap.org), The Rails Port, de código aberto ([GNU General Public License 2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)).

[![Build Status](https://travis-ci.org/openstreetmap/openstreetmap-website.svg?branch=master)](https://travis-ci.org/openstreetmap/openstreetmap-website)
[![Coverage Status](https://coveralls.io/repos/openstreetmap/openstreetmap-website/badge.svg?branch=master)](https://coveralls.io/r/openstreetmap/openstreetmap-website?branch=master)

Assim tem-se as seguintes aplicações já prontas:

* O site, que inclue autenticação e contas de usuários
* A API de edição XML [API](https://wiki.openstreetmap.org/wiki/API_v0.6)
* Versão integrada do editor [iD](https://wiki.openstreetmap.org/wiki/ID)
* O Front-end do projeto OSM
* Recebimento de dados de GPS GPX e sua interface gráfica.



# Instalação Manual

Todos os comandos citados abaixo estão disponíveis no arquivo de script provision.sh na pasta de script dentro de Vagrant/setub. Usar o Ubuntu 16.04 com os programas:

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
