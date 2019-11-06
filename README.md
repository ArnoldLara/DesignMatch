# README

Compilation steps:
* Install ruby 2.6.3 (rbenv is recommended)
* Run sudo rbenv global 2.6.3
* Run rbenv rehash
* Run gem i bundler -v 1.17.3
* Run bundle install or bundle update

Local testing:

For local testing there's a sqlite3 database in place.
To run the application execute "rails server"

Required libraries
* imagemagick

Execution:
run bundle install
run rails s -p 3000 -b 0.0.0.0 -d

Crontab:
run whenever --update-crontab
run crontab -e and edit the RAILS_ENV to development

