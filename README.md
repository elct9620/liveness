# Liveness

The Rack middleware to provide health check endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liveness'
```

## Usage

Configuration the Liveness to add dependency.

```ruby
Liveness.config do |c|
  c.add :postgres, timeout: 10
end
```

## Dependency Providers

| Name       | Descroption                                           |
|------------|-------------------------------------------------------|
| `postgres` | The PostgreSQL adapter which for `ActiveRecord::Base` |
| `mysql`    | The MySQL adapter which for `ActiveRecord::Base`      |

## Roadmap

* [x] Status Endpoint
* [ ] Metrics Endpoint (for single dependency)
* [ ] Dependency Provider
  * [ ] PostgreSQL
    * [x] ActiveRecord
    * [ ] Sequel
  * [ ] MySQL
    * [x] ActiveRecord
    * [ ] Sequel
  * Redis

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/liveness. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/elct9620/liveness/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Liveness project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/liveness/blob/main/CODE_OF_CONDUCT.md).
