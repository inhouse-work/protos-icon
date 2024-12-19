# frozen_string_literal: true

module Protos
  module Icon
    module Inhouse
      def self.build(name, ...)
        filepath = lookup(name)
        Component.new(filepath)
      end

      def self.lookup(name, ...)
        assets = Pathname.new(GEM_ROOT).join("assets/inhouse")

        assets
          .join("#{name}.svg")
          .tap do |path|
            File.exist?(path) or raise MissingIcon, "Unknown icon: #{name}"
          end
      end
    end
  end
end
