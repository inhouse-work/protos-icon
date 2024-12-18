# frozen_string_literal: true

require "phlex"

require_relative "icon/version"
require_relative "icon/heroicons"
require_relative "icon/component"

module Protos
  module Icon
    # Your code goes here...

    GEM_ROOT = Pathname.new(__dir__).join("..", "..").expand_path
    public_constant :GEM_ROOT

    def self.heroicon(name, variant: :solid)
      Heroicons.new(name, variant:)
    end

    def self.custom(name, **)
      Custom.new(name)
    end

    def icon(...)
      render Protos::Icon.heroicon(...)
    end
  end
end
