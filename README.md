weather
=======

This app pulls weather data via the weather underground api.  It is currently only setup for US zipcode data.


#Directions for use

rvm use ruby-1.9.3-p374

bundle install

bundle exec rake db:migrate

bundle exec rake db:test:prepare

bundle exec rake

bundle exec rails s

http://localhost:3000