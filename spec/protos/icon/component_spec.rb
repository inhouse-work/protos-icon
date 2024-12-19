# frozen_string_literal: true

RSpec.describe Protos::Icon::Component do
  before do
    stub_const(
      "TestComponent", Class.new(Phlex::HTML) do
        include Protos::Icon

        def view_template
          icon("academic-cap", variant: :mini)
          icon("twitter", variant: :mini)
        end
      end
    )

    stub_const(
      "ErrorComponent", Class.new(Phlex::HTML) do
        include Protos::Icon

        def view_template
          icon("does-not-exist")
        end
      end
    )
  end

  it "handles non-existent icons" do
    component = ErrorComponent.new

    expect { component.call }
      .to raise_error Protos::Icon::MissingIcon
  end

  it "can be included in a component" do
    component = TestComponent.new
    output = component.call

    expect(output.start_with?("<svg")).to be true
  end
end
