# frozen_string_literal: true

RSpec.describe Protos::Icon do
  it "has a version number" do
    expect(Protos::Icon::VERSION).not_to be_nil
  end

  describe ".heroicon" do
    it "returns a heroicon" do
      path = "assets/heroicons/16/solid/academic-cap.svg"
      svg = File.read(path)
      component = described_class.heroicon("academic-cap", variant: :micro)
      output = component.call
      expect(output).to eq(svg)
    end
  end
end
