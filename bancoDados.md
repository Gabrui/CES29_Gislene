# Passos realizados na configuração do projeto para migrar o banco de dados

Os passos que eu fiz para migrar o projeto, dado que eu já instalei e criei o usuário no PostgreSQL.
Você só precisa dar bundler install, rake db:setup e rake db:migrate.

## Gemfile
Modifiquei gemfile:
```
# Usar o postgres junto com Active Record
gem 'pg'
```

## Dependências

Rode o bundler install para instalar as dependências
```
bundler install
```

## Configurações
Mudei o arquivo config/database.yml, trocando o adapter para postgresql
```
adapter: postgresql
```



## Migrar o banco de dados

```
rake db:setup
rake db:migrate
```
