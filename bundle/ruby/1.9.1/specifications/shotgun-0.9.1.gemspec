# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "shotgun"
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Tomayko"]
  s.date = "2015-03-01"
  s.description = "Reloading Rack development server"
  s.email = "rtomayko@gmail.com"
  s.executables = ["shotgun"]
  s.files = ["bin/shotgun"]
  s.homepage = "https://github.com/rtomayko/shotgun"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Reloading Rack development server"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0"])
    else
      s.add_dependency(%q<rack>, [">= 1.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0"])
  end
end
