# frozen_string_literal: true

require "protos"
require "phlex"

require_relative "icon/version"
require_relative "icon/heroicons"
require_relative "icon/inhouse"
require_relative "icon/component"
require_relative "icon/heroicon_component"

module Protos
  module Icon
    # Your code goes here...
    class Error < StandardError; end
    MissingIcon = Class.new(Error)

    GEM_ROOT = Pathname.new(__dir__).join("..", "..").expand_path
    public_constant :GEM_ROOT

    def self.lookup(constant, name)
      "Protos::Icon::#{constant}::#{name}".constantize
    rescue NameError
      nil
    end

    def self.find(name)
      [Heroicons, Inhouse].each do |constant|
        component = lookup(constant, name.capitalize)
        return component if component
      end

      raise MissingIcon, "Unknown icon: #{name}"
    end

    def icon(name, ...)
      component = Protos::Icon.find(name).new(...)
      render component
    end
  end
end
