# Aureso Exercise
[![Build Status](https://travis-ci.org/atharvasystem/aureso_exercise.svg?branch=master)](https://travis-ci.org/atharvasystem/aureso_exercise)

Rails 4.1 application

Public API Interface responds to the following requests:

    [GET] models/:model_slug/model_types
    [POST] models/:model_slug/model_types_price/:model_type_slug

##### Note:

* API authentication with organization access_token is implemented.
* access_token must be passed as a request header parameter for authentication.

Please follow below steps for application setup:

1. Here we use **rvm** for ruby version management. First have **rvm** installed with your shell console.

        $ \curl -sSL https://get.rvm.io | bash -s stable

2. Go some workspace you would setup this development environement and clone git repository.

        $ git clone https://github.com/atharvasystem/aureso_exercise.git

3. DB setup.

        $ rake db:drop && rake db:setup

4. After DB setup there will be some data inserted in db for organization. To get access_token, please go to the console.

        $ rails c
        Loading development environment (Rails 4.1.0)
        2.1.1 :001 > Organization.first.access_token
          Organization Load (0.2ms)  SELECT  "organizations".* FROM "organizations"   ORDER BY "organizations"."id" ASC LIMIT 1
          => "11b67dc53ea3422f9d43633e73a4da56" 


(TDD)

### Run rspec
        $ rake
        $ rspec spec --format documentatoin

### Screenshots

    GET API
![alt tag](https://raw.githubusercontent.com/atharvasystem/aureso_exercise/master/public/Screenshot_GET_API.png)

    POST API
![alt tag](https://raw.githubusercontent.com/atharvasystem/aureso_exercise/master/public/Screenshot_POST_API.png)
