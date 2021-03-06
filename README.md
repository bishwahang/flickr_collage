# FlickrCollage
Give the list of tags (maximum 10) and output filename, the gem searches for photos using Flickr API and creates a collage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flickr_collage'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flickr_collage

## Usage
Imagemagick needs to be installed:
```
sudo apt-get install imagemagick libmagickwand-dev
```
Also, FlickrApi key needs to be set in the environment.

```
export FLICKR_API_KEY='your api key goes here'
```
    
For help:

```
flickrcollage -h
```


For demo:

```
flickrcollage -t list,of,tags -o output_filename
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bishwahang/flickr_collage. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

