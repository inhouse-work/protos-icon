# frozen_string_literal: true

# This file was generated by the `generators/inhouse.rb` generator.

# rubocop:disable Layout/LineLength
module Protos
  module Icon
    module Inhouse
      class UnorderedList < Component
        def view_template
          svg(
            **attrs,
            role: "presentation",
            aria_hidden: "true",
            height: "16",
            width: "16",
            xmlns: "http://www.w3.org/2000/svg",
            fill: "none",
            viewbox: "0 0 17 10"
          ) do |s|
            s.path(
              stroke: "currentColor",
              stroke_linecap: "round",
              stroke_width: "2",
              d: "M6 1h10M6 5h10M6 9h10M1.49 1h.01m-.01 4h.01m-.01 4h.01"
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Layout/LineLength
