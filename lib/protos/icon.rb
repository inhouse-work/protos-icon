# frozen_string_literal: true

require "protos"
require "phlex"
require "dry/inflector"

require_relative "icon/version"
require_relative "icon/heroicon"
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

    INFLECTOR = Dry::Inflector.new

    def self.lookup(constant, name)
      klass = "#{constant}::#{name}"
      INFLECTOR.constantize(klass)
    rescue NameError
      nil
    end

    def self.find(name)
      [Heroicon, Inhouse].each do |constant|
        component = lookup(constant, INFLECTOR.camelize(name))
        return component if component
      end

      raise MissingIcon, "Unknown icon: #{name}"
    end

    def icon(name, ...)
      component = Protos::Icon
        .find(name)
        .new(...)
      render component
    end
  end
end
