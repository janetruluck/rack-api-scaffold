Basic Rack API Scaffold
===
This is a very basic Rack API scaffold. It provides persistance via ActiveRecord for your favorite database, 
a basic user model and authentication. 

##Uses:

* Bcrypt for password hashing
* Grape for simple api creation
* ActiveRecord for persistance

# System Requirements

* ruby 1.9.3
* see Gemfile

# Installation

* `bundle install`
* `rake db:migrate && rake db:test:prepare`
* `rspec spec`

# Development

* Run console: `racksh`
* Generate migration file: `rake g:migration NAME=migration_name`
* All ActiveRecord rake tasks are accessible: `db:migrate`, `db:drop`, `db:seed`, etc
* Start the server: `rackup`
