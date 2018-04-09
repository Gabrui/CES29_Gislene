# CES29_Gislene

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

