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

### Named Dependency

```ruby
Liveness.config do |c|
  c.add :postgres, name: :primary_db, timeout: 10
  c.add :postgres, name: :read_replica, timeout: 10
end
```
### Access Protected

```ruby
Liveness.config do |c|
  c.token = 'unm@tnh8ugq-WAR-myr'
end
```

To access the status endpoint should add `?token=unm@tnh8ugq-WAR-myr` params to access it.

```ruby
Liveness.config do |c|
  c.ip_whitelist = ['192.168.0.0/24']
end
```

To access the status endpoint should called from `127.0.0.1` or `::1` or under `192.168.0.0/24`.

### Customize Connector

```ruby
Liveness.config do |c|
  c.add :redis, timeout: 10 do
    Redis.new(url: 'redis://example:6379/15')
  end
end
```

### Rails Application

Mount the `Liveness::Status` to `config/routes.rb`

```ruby
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount Liveness::Status => '/health'
end
```

## Dependency Providers

| Name       | Description                                           |
|------------|-------------------------------------------------------|
| `postgres` | The PostgreSQL adapter which for `ActiveRecord::Base` |
| `mysql`    | The MySQL adapter which for `ActiveRecord::Base`      |
| `redis`    | Test Redis via `redis-rb` gem via `#ping` method      |

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
  * [x] Redis
  * [ ] HTTP Endpoint

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/liveness. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/elct9620/liveness/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Liveness project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/liveness/blob/main/CODE_OF_CONDUCT.md).
