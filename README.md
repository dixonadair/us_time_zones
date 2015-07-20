# UsTimeZones

This gem takes in a set of coordinates and returns a US time zone as long as the input coordinates are in the US. The US’s time zone boundaries are surprisingly unusual, and the Google Maps time zone API, as well as other time zone APIs I have tested, do not perfectly account for some of the more esoteric boundaries.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'us_time_zones', '~> 2.0.8'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install us_time_zones

## Usage

TZ.whichTZ?([LAT, LNG]) #==> returns US TIME ZONE

Example:
TZ.whichTZ?([33, -84]) #==> returns “US Eastern Time Zone”

If outside the US:
==> returns "Unable to determine time zone for coordinates outside the US"
OR
==> returns “Error”


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/us_time_zones.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

