# Shine application using RoR & AngularJS.

## Setup
```
$ cd ~/workspace
$ git clone git@github.com:balakirevs/shine.git
$ cd shine
$ git checkout v2
$ bundle install

$ psql postgres
postgres> createuser --createdb --login -P shine
postgres> CREATE USER shine PASSWORD 'shine';
postgres> ALTER USER shine WITH SUPERUSER;

$ bundle exec rails db:create
$ bundle exec rails db:migrate
$ bundle exec rails db:seed
$ bundle exec rails webpacker:install
$ foreman start
```
## Run Tests
```
$ bundle exec rspec spec/
$ bundle exec rake teaspoon
```

## Dependencies

* **@ruby:** 2.4.1
* **@rails:** 5.1.3
* **@postgres:** 9.6
* **@angular:** 4.1.3
* **@bootstrap:** 3.3.7
* **@node:** 6.10.2
* **@webpack:** 2.6.1
* **@devise:** 4.3.0
* **@karma:** 1.7.0