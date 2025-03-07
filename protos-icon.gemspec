# frozen_string_literal: true

require_relative "lib/protos/icon/version"

Gem::Specification.new do |spec|
  spec.name = "protos-icon"
  spec.version = Protos::Icon::VERSION
  spec.authors = ["Nolan J Tait"]
  spec.email = ["nolanjtait@gmail.com"]

  spec.summary = ""
  spec.description = ""
  spec.homepage = "https://github.com/inhouse-work/protos-icon"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dry-inflector", "~> 1"
  spec.add_dependency "phlex", "~> 2"
  spec.add_dependency "protos", "~> 1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
