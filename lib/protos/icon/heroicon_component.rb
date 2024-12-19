module Protos
  module Icon
    class HeroiconComponent < Component
      param :name, reader: false
      option :variant, reader: false, default: -> { :solid }

      def view_template
        icon_component.public_send(@variant)
      end

      def icon_component
        "Protos::Icon::Heroicon::#{@name.camelize}"
          .constantize
          .new(**attrs)
      rescue NameError
        raise MissingIcon, "Unknown icon: #{@name}"
      end
    end
  end
end
