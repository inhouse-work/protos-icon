# frozen_string_literal: true

RSpec.describe Protos::Icon do
  it "has a version number" do
    expect(Protos::Icon::VERSION).not_to be_nil
  end

  describe ".find" do
    it "returns a custom icon" do
      path = "assets/inhouse/twitter.svg"
      svg = File.read(path)
      component = described_class.find("twitter")
      output = component.new.call
      expect(output).to eq(svg)
    end
  end
end
