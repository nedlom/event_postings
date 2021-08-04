# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - Sinatra is framework used.
- [x] Use ActiveRecord for storing information in a database - activerecord gem used for database/model
- [x] Include more than one model class (e.g. User, Post, Category) - user and event classes
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - user has many events
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - events belong to user
- [x] Include user accounts with unique login attribute (username or email) - unique email login attribute
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - CRUD routes implemented in events controller
- [x] Ensure that users can't modify content created by other users - helpers prevent users from modifying events that doesn't belong them
- [x] Include user input validations - validations in user and events classes
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - Sinatra Flash utilized
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - each in README

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message