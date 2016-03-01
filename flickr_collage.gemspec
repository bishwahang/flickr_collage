# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flickr_collage/version'

Gem::Specification.new do |spec|
  spec.name          = "flickr_collage"
  spec.version       = FlickrCollage::VERSION
  spec.authors       = ["Bishwa Hang Rai"]
  spec.email         = ["bishwahang.kirat@gmail.com"]

  spec.summary       = %q{Gets tags to search from users and creates a collage of 10 pictures.}
  spec.description   = %q{Gets tags to search from users and creates a collage of 10 pictures.}
  spec.homepage      = "https://github.com/bishwahang/flickr_collage"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/bishwahang/"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rmagick"
end
