# frozen_string_literal: true

require_relative "helpers"

OUTPUT_DIR = Pathname.new("lib/protos/icon/inhouse").freeze

RUBOCOPS = %w[
  Layout/LineLength
].join(", ")

TEMPLATE = ERB.new <<~ERB
  # frozen_string_literal: true

  # This file was generated by the `generators/inhouse.rb` generator.

  # rubocop:disable #{RUBOCOPS}
  module Protos
    module Icon
      module Inhouse
        class <%= icon_class_name %> < Component
          def view_template
  <%= icon %>
          end
        end
      end
    end
  end
  # rubocop:enable #{RUBOCOPS}
ERB

require "debug"

class ResourcePath
  REGEXP = %r{inhouse/(?<name>.+)\.svg}

  attr_reader :name

  def initialize(path)
    @path = path
    @name = path.to_s.match(REGEXP).captures.first
  end

  def icon_class_name
    @name.split("-").map(&:capitalize).join
  end

  def filename
    @path.basename.to_s.split(".").first.tr("-", "_")
  end

  def read
    File.read(@path)
  end
end

class Resource
  attr_reader :name

  def initialize(name, path)
    @name = name
    @path = path
  end

  def file_name
    OUTPUT_DIR.join("#{@path.filename}.rb")
  end

  def relative_file_path
    file_name.relative_path_from(Pathname.new("lib")).to_s
  end

  def icon
    build_icon(@path)
  end

  private

  def build_icon(path)
    Phlexing::Converter
      .convert(path.read)
      .sub("svg(", "svg(\n  **attrs,")
      .split("\n")
      .map { |line| (" " * 10) + line }
      .join("\n")
  end
end

resource_paths = Pathname.glob("assets/inhouse/**/*.svg").map do |path|
  ResourcePath.new(path)
end

resources = resource_paths
  .map do |path|
    Resource.new(path.icon_class_name, path)
  end

module_file = OUTPUT_DIR.join("..", "inhouse.rb")
add_autoload_entries(module_file, resources)

resources.with_progress.each do |resource|
  File.write(
    resource.file_name,
    TEMPLATE.result_with_hash(
      {
        icon_class_name: resource.name,
        icon: resource.icon
      }
    )
  )
end
