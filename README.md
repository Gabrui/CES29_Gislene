# Projeto com Padrão OSM (Open Street Map)

Utilizar a máquina virtual VirtualBox com o gerenciador Vagrant para rodar o servidor.
https://www.vagrantup.com/downloads.html
https://www.virtualbox.org/wiki/Downloads

```
sudo apt-get install vagrant
sudo apt-get install virtualbox
```

De posse dos programas acima instalados e rodando corretamente, vá na pasta do projeto e inicie a máquina virtual:

```
vagrant up
```
OBS: O virtual box reclamou do secure boot no meu PC, tive que desabilitá-lo.

Esse comando irá baixar a imagem de uma nova máquina virtual e instalar todas as dependências (banco de dados) nela, isso pode demorar um pouco pela primeira vez.

Assim que a instalação for concluída, você pode logar na máquina virtual por meio do comando
```
vagrant ssh
```

Dentro da máquina virtual existe uma pasta compartilhada do projeto, vá para ela:
```
cd /srv/openstreetmap-website/
```

Para rodar o servidor, use o comando:
```
rails server --binding=0.0.0.0
```

Qualquer modificação no código da pasta do projeto refletirá na máquina virtual, que usa a pasta compartilhada.



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
