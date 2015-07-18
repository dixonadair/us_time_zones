# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'us_time_zones/version'

Gem::Specification.new do |spec|
  spec.name          = "us_time_zones"
  spec.version       = UsTimeZones::VERSION
  spec.authors       = ["Dixon Adair"]
  spec.email         = ["dixonadairv@gmail.com"]

  spec.summary       = "This gem takes in a set of coordinates and returns a US time zone."
  spec.description   = "I made this gem because the current Google Maps API for time zones is not completely precise when it comes to US time zones. There are certain esoteric time zone boundaries in the US for which the Google Maps time zone API does not account perfectly."
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  # Below added by me
  spec.add_development_dependency "httparty", '~> 0'
  spec.add_development_dependency "json", '~> 0'
  # spec.add_runtime_dependency "httparty", '~> 0'
  # spec.add_runtime_dependency "json", '~> 0'
end
