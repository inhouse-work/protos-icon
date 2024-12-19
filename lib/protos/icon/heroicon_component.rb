module Protos
  module Icon
    class HeroiconComponent < Component
      param :name
      option :variant

      def self.build(name, variant: :solid, **)
        "Protos::Icon::Heroicon::#{name.camelize}"
          .constantize
          .new(variant: variant)
      end
    end
  end
end
