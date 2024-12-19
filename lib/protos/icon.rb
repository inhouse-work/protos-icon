# frozen_string_literal: true

require "phlex"

require_relative "icon/version"
require_relative "icon/heroicons"
require_relative "icon/inhouse"
require_relative "icon/component"

module Protos
  module Icon
    # Your code goes here...
    class Error < StandardError; end
    MissingIcon = Class.new(Error)

    GEM_ROOT = Pathname.new(__dir__).join("..", "..").expand_path
    public_constant :GEM_ROOT

    def self.heroicon(name, variant: :solid)
      Heroicons.build(name, variant:)
    end

    def self.inhouse(name, **)
      Inhouse.build(name)
    end

    def self.build(name, ...)
      component = maybe(Heroicons, name, ...)
      component ||= maybe(Inhouse, name, ...)
      raise MissingIcon, "Could not find an icon for #{name}" unless component

      component
    end

    def self.maybe(mod, name, ...)
      mod.build(name, ...)
    rescue MissingIcon
      nil
    end

    def icon(...)
      raise MissingIcon unless component = Protos::Icon.build(...)

      render component
    end
  end
end
