require_relative "helpers"

OUTPUT_DIR = Pathname.new("lib/protos/icon/heroicon").freeze

RUBOCOPS = %w[
  Layout/LineLength
].join(", ")

TEMPLATE = ERB.new <<~ERB
  # frozen_string_literal: true

  # This file was generated by the `generators/heroicon.rb` generator.

  # rubocop:disable #{RUBOCOPS}
  module Protos
    module Icon
      module Heroicon
        class <%= icon_class_name %> < HeroiconComponent
          def solid
  <%= solid_icon %>
          end

          def outline
  <%= outline_icon %>
          end
        end
      end
    end
  end
  # rubocop:enable #{RUBOCOPS}
ERB

require "debug"

class ResourcePath
  REGEXP = %r{heroicons/24/(?<variant>solid|outline)/(?<name>.+)\.svg}

  attr_reader :variant, :name

  def initialize(path)
    @path = path
    @variant, @name = path.to_s.match(REGEXP).captures
  end

  def icon_class_name
    @name.split("-").map(&:capitalize).join
  end

  def solid?
    @variant == "solid"
  end

  def outline?
    @variant == "outline"
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

  def initialize(name, paths)
    @name = name
    @solid_path = paths.find(&:solid?)
    @outline_path = paths.find(&:outline?)
  end

  def file_name
    OUTPUT_DIR.join("#{@solid_path.filename}.rb")
  end

  def relative_file_path
    file_name.relative_path_from(Pathname.new("lib")).to_s
  end

  def solid_icon
    build_icon(@solid_path)
  end

  def outline_icon
    build_icon(@outline_path)
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

resource_paths = Pathname.glob("assets/heroicons/24/**/*.svg").map do |path|
  ResourcePath.new(path)
end

resources = resource_paths
  .group_by(&:icon_class_name)
  .map do |icon_class_name, paths|
    Resource.new(icon_class_name, paths)
  end

module_file = OUTPUT_DIR.join("..", "heroicon.rb")
add_autoload_entries(module_file, resources)

resources.with_progress.each do |resource|
  File.write(
    resource.file_name,
    TEMPLATE.result_with_hash(
      {
        icon_class_name: resource.name,
        solid_icon: resource.solid_icon,
        outline_icon: resource.outline_icon
      }
    )
  )
end
