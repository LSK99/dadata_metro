# Dadata

Wrapper for the [Dadata.ru](https://dadata.ru/) API: Metro stations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dadata_metro'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dadata_metro

## Usage

```ruby
require 'dadata_metro'

dadata = DadataMetro::Search.new(api_token: 'token')
dadata.call(query: "Маяк", filters: [ { city_kladr_id: "7800000000000" } ])

```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
