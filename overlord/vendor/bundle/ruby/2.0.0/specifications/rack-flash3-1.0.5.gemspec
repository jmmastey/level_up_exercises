# -*- encoding: utf-8 -*-
# stub: rack-flash3 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-flash3"
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Pat Nakajima", "Travis Reeder"]
  s.date = "2013-09-03"
  s.description = "Flash hash implementation for Rack apps."
  s.email = ["treeder@gmail.com"]
  s.homepage = "https://github.com/treeder/rack-flash"
  s.required_ruby_version = Gem::Requirement.new(">= 1.8")
  s.rubygems_version = "2.4.5"
  s.summary = "Flash hash implementation for Rack apps."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
  end
end
