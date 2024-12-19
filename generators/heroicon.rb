require_relative "helpers"

OUTPUT_DIR = Pathname.new("lib/protos/icon/heroicon").freeze

TEMPLATE = ERB.new <<~ERB
  module Protos
    module Icon
      module Heroicon
        class <%= icon_class_name %> < Component
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
ERB

class ResourcePath
  REGEXP = %r{heroicons/24/(?<variant>\w+)/(?<name>\w+).svg}

  def initialize(path)
    @variant, @name = path.to_s.match(REGEXP).captures
  end

  def icon_class_name
    @name.split("-").map(&:capitalize).join
  end
end

class Resource
  def initialize(name, paths)
    @name = name
    @solid_path, @outline_path = paths.partition do |path|
      path.variant == "solid"
    end
  end

  def file_name
    OUTPUT_DIR.join("#{name.downcase}.rb")
  end

  def solid_icon
    Phlexing::Converter.convert(@solid_path.read).sub("svg(", "svg(\n**attrs,")
  end

  def outline_icon
    Phlexing::Converter.convert(@outline_path.read).sub(
      "svg(",
      "svg(\n**attrs,"
    )
  end
end

resource_paths = Pathname.glob("assets/heroicons/**/*.svg").map do |path|
  ResourcePath.new(path)
end

resources = resource_paths
  .group_by(&:icon_class_name)
  .map do |icon_class_name, paths|
    Resource.new(icon_class_name, paths)
  end

resources.each do |resource|
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
