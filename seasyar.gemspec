# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "seasyar"
  s.version = "0.0.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fredrik Rubensson"]
  s.date = "2012-11-09"
  s.description = "Seasy integration. Active record storage for seasy and save hooks in models."
  s.email = "fredrik@eldfluga.se"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "db/config.yml",
    "db/migrate/20110906072000_create_index.rb",
    "db/migrate/20110926212900_add_source.rb",
    "db/migrate/20111116164500_add_index_name.rb",
    "db/schema.rb",
    "lib/seasyar.rb",
    "lib/seasyar/activerecordstorage.rb",
    "lib/seasyar/seasyar.rb",
    "lib/seasyar/seasydata.rb",
    "seasyar.gemspec",
    "spec/seasyar_spec.rb",
    "spec/storage_spec.rb"
  ]
  s.homepage = "http://github.com/froderik/seasyar"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "active record integration for seasy"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<seasy>, [">= 0.0.9"])
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.2"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<standalone_migrations>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<seasy>, [">= 0.0.9"])
      s.add_dependency(%q<activerecord>, ["~> 3.2"])
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<standalone_migrations>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<seasy>, [">= 0.0.9"])
    s.add_dependency(%q<activerecord>, ["~> 3.2"])
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<standalone_migrations>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end

