# frozen_string_literal: true

module Protos
  module Icon
    module Heroicons
      def self.build(name, variant: :solid)
        HeroiconComponent.new(name, variant:)
      end
    end
  end
end
