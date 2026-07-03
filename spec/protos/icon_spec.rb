# frozen_string_literal: true

RSpec.describe Protos::Icon do
  it "has a version number" do
    expect(Protos::Icon::VERSION).not_to be_nil
  end

  describe ".find" do
    it "returns a custom icon" do
      component = described_class.find("twitter")
      output = component.new.call
      expect(output.start_with?("<svg")).to be true
    end

    it "returns a herocion icon" do
      component = described_class.find("academic-cap")
      output = component.new.call
      expect(output.start_with?("<svg")).to be true
    end

    it "returns a lucide icon" do
      component = described_class.find("git-branch")
      output = component.new.call
      expect(output.start_with?("<svg")).to be true
    end
  end
end
