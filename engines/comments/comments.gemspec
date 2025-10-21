require_relative "lib/comments/version"

Gem::Specification.new do |spec|
  spec.name        = "comments"
  spec.version     = Comments::VERSION
  spec.authors     = ["Richie Thomas"]
  spec.email       = ["rickthomas1980@gmail.com"]
  spec.homepage    = "https://github.com/richiethomas/blog-app"
  spec.summary     = "Comments engine for blog application"
  spec.description = "A Rails engine that provides commenting functionality for blog posts"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/richiethomas"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/richiethomas/blog-app"
  spec.metadata["changelog_uri"] = "https://github.com/richiethomas/blog-app/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.5.2"
end
