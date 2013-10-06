# ticket-tracking

## Brief overview

This is a simple ticket tracking system. Still in WIP status.

## Getting started

The same as for any other Rails app:

    [su] bundle install
    rake db:migrate
    rake db:seed
    rails s

If you wish that for Production environment, just configure database at `config/database.yml` and add `RAILS_ENV=production` to all of the DB-related commands.