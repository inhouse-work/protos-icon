# frozen_string_literal: true

module Protos
  module Icon
    class Component < Phlex::HTML
      def initialize(filepath)
        @filepath = filepath
      end

      def view_template
        unsafe_raw File.read(@filepath)
      end
    end
  end
end
