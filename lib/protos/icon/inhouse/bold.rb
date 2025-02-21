# frozen_string_literal: true

# This file was generated by the `generators/inhouse.rb` generator.

# rubocop:disable Layout/LineLength
module Protos
  module Icon
    module Inhouse
      class Bold < Component
        def view_template
          svg(
            **attrs,
            role: "presentation",
            height: "16",
            width: "16",
            data_slot: "icon",
            aria_hidden: "true",
            xmlns: "http://www.w3.org/2000/svg",
            fill: "none",
            viewbox: "0 0 14 16"
          ) do |s|
            s.path(
              stroke: "currentColor",
              stroke_linecap: "round",
              stroke_linejoin: "round",
              stroke_width: "2",
              d:
                "M3 1h4.5a3.5 3.5 0 1 1 0 7H3m0-7v7m0-7H1m2 7h6.5a3.5 3.5 0 1 1 0 7H3m0-7v7m0 0H1"
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Layout/LineLength
