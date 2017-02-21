# MagicModels

Have an existing database? MagicModels can generate models on the fly using your existing database connection.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'magic_models'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install magic_models

## Usage

MagicModels has two main functions:

+ **dump**: Generate files for your Active Record models.
+ **define**: Declare models at runtime without creating any files.

First, you'll need to point your app at an existing database. To do that, just edit your `config/database.yml`.

To define your models at runtime, just put this line in an initializer:

```ruby
MagicModels.define
```

If you want to dump your models to files, run this shell command:

```shell
$ rails runner 'MagicModels.dump'
```

## Configuration

MagicModels also offers some configuration settings:

```ruby
MagicModels.define do |config|
  # Ignore certian tables (default: schema_migrations, ar_internal_metadata)
  config.exclude 'some_table', 'some_other_table'

  # Change the dump directory (default: app/models)
  config.destination = '/path/to/your/directory'

  # Change the connection (default: ActiveRecord::Base.connection)
  config.connection = SomeOtherModel.connection

  # Declare the models within a namespace
  config.namespace = SomeModule

  # Declare a different class to inherit from (default: ActiveRecord::Base)
  config.base_class = 'SomeOtherAncestor'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Ray Zane/magic_models.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
