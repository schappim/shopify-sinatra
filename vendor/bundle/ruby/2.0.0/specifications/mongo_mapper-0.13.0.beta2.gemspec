# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongo_mapper"
  s.version = "0.13.0.beta2"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Nunemaker"]
  s.date = "2013-08-07"
  s.description = "MongoMapper is a Object-Document Mapper for Ruby and Rails"
  s.email = ["nunemaker@gmail.com"]
  s.executables = ["mmconsole"]
  s.files = ["bin/mmconsole"]
  s.homepage = "http://mongomapper.com"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "A Ruby Object Mapper for Mongo"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0"])
      s.add_runtime_dependency(%q<plucky>, ["~> 0.6.5"])
      s.add_runtime_dependency(%q<mongo>, ["~> 1.8"])
    else
      s.add_dependency(%q<activemodel>, [">= 3.0.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0"])
      s.add_dependency(%q<plucky>, ["~> 0.6.5"])
      s.add_dependency(%q<mongo>, ["~> 1.8"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 3.0.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0"])
    s.add_dependency(%q<plucky>, ["~> 0.6.5"])
    s.add_dependency(%q<mongo>, ["~> 1.8"])
  end
end
