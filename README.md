# Rubocop Custom Cops [![Build Status](https://travis-ci.org/Sage/rubocop-custom-cops.svg?branch=master)](https://travis-ci.org/Sage/rubocop-custom-cops) [![Maintainability](https://api.codeclimate.com/v1/badges/960efd688f42eaaeef91/maintainability)](https://codeclimate.com/github/Sage/rubocop-custom-cops/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/960efd688f42eaaeef91/test_coverage)](https://codeclimate.com/github/Sage/rubocop-custom-cops/test_coverage) [![Gem Version](https://badge.fury.io/rb/rubocop-custom-cops.svg)](https://badge.fury.io/rb/rubocop-custom-cops)

Container for custom Rubocop checks, called cops.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-custom-cops'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop-custom-cops

## Usage

TODO: Write usage instructions here

### Rails/ErrorsAddWithSymbol

```ruby
# bad
person.errors.add(:name, 'this text is already translated')

# good
person.errors.add(:name, :proper_key_from_local_file)
```

Background: our API provides error messages in a general, English form, as well as localized in the users languages. This is only possible when the translation happens inside `errors.add`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sage/rubocop-custom-cops. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [Apache License, Version 2.0](http://www.apache.org/licenses/).

## Code of Conduct

Everyone interacting in the Rubocop Custom Cops project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Sage/rubocop-custom-cops/blob/master/CODE_OF_CONDUCT.md).
