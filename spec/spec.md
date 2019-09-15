# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (e.g. User, Post, Category)
        Models: Book, Review, Student, Teacher
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
        Teacher has_many Books and Students
        Student has_many Reviews and Books (through Reviews)
        Book has_many Reviews and Students (through Reviews)
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
        Student belongs_to Teacher
        Review belongs_to Student and Book
        Book belongs_to Teacher
- [x] Include user accounts with unique login attribute (username or email)
        Login attribute - username
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
        Teacher can CRUD self, Students, Books, Reviews
        Student can CRUD Reviews and RU self
- [x] Ensure that users can't modify content created by other users
        Helper methods for permissions
- [x] Include user input validations
        Helper methods for permissions
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message