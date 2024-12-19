# Protos::Icon

This gem uses [phlexing](https://github.com/marcoroth/phlexing) component
generation to convert SVG icons into protos components.

Other similar libraries to check out:

- [phlex-icons](https://phlex-icons.fun/)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add protos-icon

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install protos-icon

## Usage

```ruby
require "protos-icon"

# This just returns a Phlex component
render Protos::Icon.find("academic-cap").new(variant: :solid)
```

Or you can include the module in a class and render them as an element:

```ruby
class MyComponent < Phlex::HTML
  include Protos::Icon

  def template
    icon("academic-cap", variant: :solid, class: "w-6 h-6")
  end
end
```

Or you can wrap the helper inside your own component:

```ruby
module Ui
  class Icon < ApplicationComponent
    include Protos::Icon

    param :name
    option :size, default: -> { :md }
    option :variant, default: -> { :solid }

    STYLES = {
      xs: ["w-3 h-3"],
      sm: ["w-4 h-4"],
      md: ["w-6 h-6"],
      lg: ["w-8 h-8"],
      xl: ["w-12 h-12"]
    }.freeze

    def view_template
      icon(name, variant:, **attrs)
    end

    private

    def theme
      {
        container: STYLES[size]
      }
    end
  end
end
```

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
