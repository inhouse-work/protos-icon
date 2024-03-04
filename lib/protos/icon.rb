# frozen_string_literal: true

require "phlex"

require_relative "icon/version"

module Protos
  module Icon
    # Your code goes here...

    GEM_ROOT = Pathname.new(__dir__).join("..", "..").expand_path
    public_constant :GEM_ROOT

    class Component < Phlex::HTML
      def initialize(filepath)
        @filepath = filepath
      end

      def template
        unsafe_raw File.read(@filepath)
      end
    end

    module Heroicons
      def self.new(name, variant: :solid)
        filepath = lookup(name, variant:)
        Component.new(filepath)
      end

      def self.lookup(name, variant: :solid)
        filepath = Pathname.new(GEM_ROOT)
        filepath = case variant
                   when :solid then filepath.join("assets/heroicons/24/solid")
                   when :outline then filepath.join("assets/heroicons/24/outline")
                   when :mini then filepath.join("assets/heroicons/20/solid")
                   when :micro then filepath.join("assets/heroicons/16/solid")
                   else raise ArgumentError, "Unknown variant: #{variant}"
        end

        filepath
          .join("#{name}.svg")
          .tap do |path|
            File.exist?(path) or raise ArgumentError, "Unknown icon: #{name}"
          end
      end
    end

    def self.heroicon(name, variant: :solid)
      Heroicons.new(name, variant:)
    end

    def icon(...)
      render Protos::Icon.heroicon(...)
    end
  end
end
