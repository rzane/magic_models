# MagicModels

Have an existing database? MagicModels can generate models on the fly using your existing database connection.

If you have a table called `people`, just call `MagicModels.define`. Now, you have a model called `Person`. Boom!

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

MagicModels also offers some configuration settings. `MagicModels.define` and `MagicModels.dump` accept a block:

```ruby
MagicModels.define do |config|
end

MagicModels.dump do |config|
end
```

#### Shared settings

```ruby
# Ignore certian tables (default: schema_migrations, ar_internal_metadata)
config.exclude 'some_table', 'some_other_table'

# Change the connection (default: ActiveRecord::Base.connection)
config.connection = SomeOtherModel.connection

# Declare a different class to inherit from (default: ActiveRecord::Base)
config.base_class = 'SomeOtherAncestor'
```

#### Dump-specific settings

```ruby
# Change the directory where the model files will be created (default: app/models)
config.destination = '/path/to/your/models/dir'
```

#### Define-specific settings

```ruby
# Change the namespace to create the models under. For example, if you had a table
# named 'foos', this configuration would create `SomeModule::Foo` instead of `Foo`.
config.namespace = SomeModule
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rzane/magic_models.

## Props

+ [Dr. Nic's Magic Models](https://github.com/drnic/dr-nic-magic-models)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
