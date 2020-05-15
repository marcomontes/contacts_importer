# CONTACTS IMPORTER
###### Import contacts data from CSV Files

##### Project Requirements:
``ruby 2.5.7, PostgreSQL``

##### How to run this project locally:
1. Clone the repository
2. Run bundle install command:
``bundle install``
3. Setup postgres database connection using this file:
``config/database.yml``
3. Setup active-storage - AWS S3 credentials using this file:
``config/storage.yml``
4. Create and migrate the database
* ``rails db:create``
* ``rails db:migrate``
5. Run server server using: ``rails s``

##### Some useful commands/links:
* How to Run Tests: ``rspec spec``
* [Heroku version of this project](https://csv-contacts.herokuapp.com/)
* [Sign In](https://csv-contacts.herokuapp.com/users/sign_in)
* [Sign Up](https://csv-contacts.herokuapp.com/users/sign_up)
* [GitHub Repo](https://github.com/marcomontes/contacts_importer)


##### Libraries/Frameworks Used:
* **devise** Used for authentication.
* **bootstrap** Open-source toolkit for Frontend development.
* **aws-sdk-s3** AWS SDK for Ruby, used for store CSV files on S3.
* **kaminari** Gem used for pagination.
* **activerecord-import** A library for bulk insertion of data into your database using ActiveRecord.
* **aasm** State machines for Ruby classes
