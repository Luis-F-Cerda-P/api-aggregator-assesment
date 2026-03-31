# api-aggregator-assessment
Focused Rails API endpoint that aggregates data from two external sources, applies specific business logic, persists the result to a database and returns a structured JSON response.

*This README file was inspired by [this sample](https://raw.githubusercontent.com/learnenough/rails_tutorial_sample_app_7th_ed/refs/heads/main/README.md)*
## Getting started
### Prerequisites

The setup steps expect following tools to be installed on the system.

- Git
- RVM or Ruby 3.4.8
- Postgres 16 or higher running locally with peer authentication (default on macOS/Linux). No credentials needed for development.

### Ruby & Gems
To get started with the app, clone the repo and then install the needed gems. You can clone the repo as follows:

```
$ git clone https://github.com/Luis-F-Cerda-P/api-aggregator-assessment.git
$ cd api-aggregator-assessment
```

To install the gems, you will need the same versions of Ruby (ruby-3.4.8) and Bundler (2.6.9) used to build the app. You can verify the versions by using the `cat` and `tail` commands as follows:

```
$ cat .ruby-version
ruby-3.4.8
$ tail -n1 Gemfile.lock
   2.6.9
```

Next, install the versions of `ruby` and the `bundler` as follows:

```
$ rvm get stable
$ rvm install ruby-3.4.8
$ rvm use ruby-3.4.8
```

The `bundler` gem can be installed using the `gem` command:

```
$ gem install bundler -v 2.6.9
```

Then the rest of the necessary gems can be installed with `bundle`:

```
$ bundle _2.6.9_ config set --local without 'production'
$ bundle _2.6.9_ install
```
### Database

After the gems have correctly been installed, create the database and run the migrations: 

```
$ bin/rails db:create
$ bin/rails db:migrate
```

### Test and run the app

Run the test suite to check everything has been setup correctly: 
```
$ bin/rails test
```

Once tests have passed you can start the rails server: 

```
$ bin/rails server
```
With the app running you can send a request to the main endpoint of the app from a different terminal session:
```
$ curl --location 'http://localhost:3000/api/v1/user_status/1'
```
The response should have a 200 status code with the following body: 
```json
{
  "id": 1,
  "full_name": "Emily Johnson",
  "experience": "Rookie",
  "pending_task_count": 1,
  "next_urgent_task": "Learn Javascript"
}
```