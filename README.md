# Protos::Icon

Icon component for Phlex with heroicons built in so far. It currently just uses
`unsafe_raw` to output the content of the `.svg` files downloaded from the
heroicons repo.

This gem does not add any classes or contain the SVG in a container.
It just outputs the SVG. It would be expected you would build this into your own
component or helper.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add protos-icon

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install protos-icon

## Usage

```ruby
require "protos-icon"

# This just returns a Phlex component
render Protos::Icon.heroicon("academic-cap", variant: :mini)
```

Or you can include the module in a class and render them as an element:

```ruby
class MyComponent < Phlex::HTML
  include Protos::Icon

  def template
    div(class: "w-6 h-6") do
      icon("academic-cap", variant: :mini)
    end
  end
end
```

This will call render on the icon component and output it directly to the
component.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/inhouse-work/protos-icon.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
