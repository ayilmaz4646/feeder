$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "feeder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "feeder"
  s.version     = Feeder::VERSION
  s.authors     = ["sitescamp"]
  s.email       = ["ahmet.yilmaz@nimbo.com.tr"]
  s.homepage    = "https://github.com/ayilmaz4646/feeder.git"
  s.summary     = "Summary of Feeder."
  s.description = "Description of Feeder."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "4.2.3"

  s.add_development_dependency "sqlite3"
end
