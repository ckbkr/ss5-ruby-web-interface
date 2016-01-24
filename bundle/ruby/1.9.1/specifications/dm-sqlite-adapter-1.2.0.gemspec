# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dm-sqlite-adapter"
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Kubb"]
  s.date = "2011-10-09"
  s.description = "Sqlite3 Adapter for DataMapper"
  s.email = "dan.kubb@gmail.com"
  s.extra_rdoc_files = ["LICENSE"]
  s.files = ["LICENSE"]
  s.homepage = "http://github.com/datamapper/dm-sqlite-adapter"
  s.require_paths = ["lib"]
  s.rubyforge_project = "datamapper"
  s.rubygems_version = "1.8.23"
  s.summary = "Sqlite3 Adapter for DataMapper"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<do_sqlite3>, ["~> 0.10.6"])
      s.add_runtime_dependency(%q<dm-do-adapter>, ["~> 1.2.0"])
      s.add_development_dependency(%q<dm-migrations>, ["~> 1.2.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3.2"])
    else
      s.add_dependency(%q<do_sqlite3>, ["~> 0.10.6"])
      s.add_dependency(%q<dm-do-adapter>, ["~> 1.2.0"])
      s.add_dependency(%q<dm-migrations>, ["~> 1.2.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rspec>, ["~> 1.3.2"])
    end
  else
    s.add_dependency(%q<do_sqlite3>, ["~> 0.10.6"])
    s.add_dependency(%q<dm-do-adapter>, ["~> 1.2.0"])
    s.add_dependency(%q<dm-migrations>, ["~> 1.2.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rspec>, ["~> 1.3.2"])
  end
end
