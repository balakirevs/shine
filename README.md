# Shine application using RoR & AngularJS.

```
$ cd ~/workspace
$ git@github.com:balakirevs/shine.git
$ cd shine
$ bundle install
$ bundle exec rake bower:install

$ psql postgres
postgres> createuser --createdb --login -P shine
postgres> CREATE USER shine PASSWORD 'shine';
postgres> ALTER USER shine WITH SUPERUSER;

$ bundle exec rake db:drop
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed

$ bundle exec rspec spec/
$ bundle exec rake teaspoon

```