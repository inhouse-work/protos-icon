module Protos
  module Icon
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
  end
end
