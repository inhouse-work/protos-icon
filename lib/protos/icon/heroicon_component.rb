# frozen_string_literal: true

module Protos
  module Icon
    class HeroiconComponent < Component
      option :variant, reader: false, default: -> { :solid }

      def view_template
        public_send(@variant)
      end
    end
  end
end
