# Fitune Project: Rails + API + Postgres

* Ruby version: 2.7.1

* System dependencies
1. install dependencies
```
bundle install
```


* Database creation

```
rails db:create
```

* Database initialization
```
rails db:migrate
rails db:seed
```

* How to run the project
```
rails server
```

* Import collection file into postman (search the file: fitune.postman_collection.json)
1. search and execute the login request (automatic is gonna set the environment variables so you can use admin resources with the token)
body:
```
{
    "username": "admin",
    "password": "$dm!nhola123"
}
```

* Deployment instructions (i am not going to deploy because my heroku account is disabled)
1. install heroku cli
2. create a heroku project and link it with the github repo
3. deploy it and we can enable automatically deploy
4. after new changes commits and git push heroku master
5. enable postgress addon and get the database url and add it into heroku environments
6. heroku run rails db:migrate, heroku run rails db:seed
7.  heroku restart
