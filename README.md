# Installation and Setup

## Prerequisites  
 &nbsp; 

Before you begin, make sure you have the following installed on your machine:

- Ruby 2.6.3
- PostgreSQL
- ImageMagick

&nbsp; 
### Ruby
&nbsp; 

Install Ruby. You can download Ruby from the official website: https://www.ruby-lang.org/en/downloads/

 &nbsp; 
### PostgreSQL
 &nbsp; 
1. Install PostgreSQL:

    - For macOS, you can use Homebrew to install PostgreSQL by running the following command in your terminal:

        `brew install postgresql`

    - For Ubuntu or Debian-based Linux distributions, you can install PostgreSQL by running the following command:

        `sudo apt-get install postgresql postgresql-contrib`

    - For Windows, you can download the PostgreSQL installer from the official website: https://www.postgresql.org/download/windows/

2. Start the PostgreSQL server:

    - For macOS, you can start the PostgreSQL server by running the following command in your terminal:

        `brew services start postgresql`

    - For Ubuntu or Debian-based Linux distributions, the PostgreSQL server should start automatically after installation. If it doesn`t, you can start it by running the following command:

        `sudo systemctl start postgresql`

    - For Windows, you can start the PostgreSQL server using the "pg_ctl" utility. Open a command prompt and navigate to the PostgreSQL installation directory. Then, run the following command to  start the server:

        `pg_ctl -D "C:/Program Files/PostgreSQL/13/data" start`

3. Create a PostgreSQL user:

    - Open a command prompt or terminal and run the following command to access the PostgreSQL command line interface:

        `psql postgres`

    - Once you're in the PostgreSQL CLI, run the following command to create a new user:

        `CREATE USER <username> WITH PASSWORD '<password>`;`

        Replace username and password with your desired username and password.

    - Exit the PostgreSQL CLI by running the following command:

        `\q`

&nbsp; 
### Installing ImageMagick
&nbsp; 

ImageMagick is a software suite used to create, edit, and compose bitmap images. You can install it on your machine by following the instructions below:
&nbsp; 

**MacOS**
&nbsp; 

If you're on a Mac, you can use Homebrew to install ImageMagick. Open your terminal and run the following command:

`brew install imagemagick`

**Linux**
&nbsp; 

If you're on a Linux machine, you can use your package manager to install ImageMagick. Open your terminal and run one of the following commands:

- Ubuntu

    `sudo apt-get install imagemagick`

- Fedora

    `sudo dnf install ImageMagick`

- CentOS

    `sudo yum install ImageMagick`

**Windows**
&nbsp;

If you're on a Windows machine, you can download and install ImageMagick from the official website: https://imagemagick.org/script/download.php

&nbsp; 
## Setup Application
&nbsp; 

### Clone the repository:

`git clone <repository-url>`

&nbsp; 
### Install the required gems:

`bundle install`

&nbsp; 
### Update the config/database.yml file to use your PostgreSQL database settings:

```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <username>
  password: <password>
  host: localhost
  port: 5432

development:
  <<: *default
  database: <database_name>_development

test:
  <<: *default
  database: <database_name>_test
```

Replace <username>, <password>, and <database_name> with your PostgreSQL database settings.

&nbsp; 
### Set up the database:

`rails db:create db:migrate db:seed`

&nbsp; 
### Start the server:

`rails server`

You should now be able to access the application by going to http://localhost:3000 in your web browser.

&nbsp; 
## Running Tests

&nbsp; 
To run the tests for this application, you can use the following command:

`rails test`

This will run all