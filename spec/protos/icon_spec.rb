# frozen_string_literal: true

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
end
