# Surveymonkey::Client

This gem is designed to communicate with the Survey Monkey API through instantiation of the main class SurveyMonkey::Client. To instantiate you need the API key from a Survey Monkey account.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'surveymonkey-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install surveymonkey-client

## Usage
Authentication:

```ruby
client = Surveymonkey::Client.new(api_key, access_token)
```

User details:

```ruby
surveys = client.user
```

Survey Data:

```ruby
surveys = client.surveys
survey_details = client.survey_details(survey_id)
```

Respondent Data:

```ruby
respondents = client.respondents(survey_id)
responses = client.responses(survey_id, respondent_ids)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/surveymonkey-client.
