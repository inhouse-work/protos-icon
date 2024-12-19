# frozen_string_literal: true

module Protos
  module Icon
    module Heroicons
      def self.build(name, variant: :solid)
        HeroiconComponent.build(name, variant:)
      rescue NameError
        raise MissingIcon, "Unknown icon: #{name}"
      end
    end
  end
end
