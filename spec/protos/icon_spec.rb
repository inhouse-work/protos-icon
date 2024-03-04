# frozen_string_literal: true

TestComponent = Class.new(Phlex::HTML) do
  include Protos::Icon

  def template
    icon("academic-cap", variant: :mini)
  end
end

RSpec.describe Protos::Icon do
  it "has a version number" do
    expect(Protos::Icon::VERSION).not_to be nil
  end

  it "does something useful" do
    path = "assets/heroicons/16/solid/academic-cap.svg"
    svg = File.read(path)
    component = described_class.heroicon("academic-cap", variant: :micro)
    output = component.call
    expect(output).to eq(svg)
  end

  it "can be included in a component" do
    component = TestComponent.new
    output = component.call

    expect(output.start_with?("<svg")).to be true
  end
end
