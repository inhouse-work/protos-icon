RSpec.describe Protos::Icon::Component do
  before do
    stub_const(
      "TestComponent", Class.new(Phlex::HTML) do
        include Protos::Icon

        def view_template
          icon("academic-cap", variant: :mini)
        end
      end
    )
  end

  it "can be included in a component" do
    component = TestComponent.new
    output = component.call

    expect(output.start_with?("<svg")).to be true
  end
end
