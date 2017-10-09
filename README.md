# Queeze Builder


## Rules

* Ability to sign in / sign up via devise through email & password
* Ability to sign in via Google
* Ability to sign in via Twitter
* Ability to create a questions
* Ability to search by questions title & body via solr
* Ability to create a answers
* Ability to link questions with answers
* Ability to create questionnaires
* Ability to link questionnaires with questions


## Instalation

* clone the project
* install ruby 2.4.0 or a newer version (if you don't have it installed already)
* run bundle install
* rake db:create
* rake db:migrate
* rake sunspot:solr:start
* rake sunspot:reindex
