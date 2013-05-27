$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dry_controller/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dry_controller"
  s.version     = DryController::VERSION
  s.authors     = ["Max Schulze"]
  s.email       = ["max@maxschulze.com"]
  s.homepage    = "http://maxschulze.com"
  s.summary     = "Simple dry controller as a basis for my projects."
  s.description = "It creates some default methods and makes it easy to implement basic CRUD like behaviour."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
end
