# -*- encoding: utf-8 -*-
# stub: cucumber 1.3.17 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber"
  s.version = "1.3.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Aslak Helles\u{f8}y"]
  s.date = "2014-09-13"
  s.description = "Behaviour Driven Development with elegance and joy"
  s.email = "cukes@googlegroups.com"
  s.executables = ["cucumber"]
  s.files = ["bin/cucumber"]
  s.homepage = "http://cukes.info"
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubygems_version = "2.2.2"
  s.summary = "cucumber-1.3.17"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 1.1.3"])
      s.add_runtime_dependency(%q<gherkin>, ["~> 2.12"])
      s.add_runtime_dependency(%q<multi_json>, ["< 2.0", ">= 1.7.5"])
      s.add_runtime_dependency(%q<multi_test>, [">= 0.1.1"])
      s.add_development_dependency(%q<aruba>, ["= 0.5.2"])
      s.add_development_dependency(%q<json>, ["~> 1.7"])
      s.add_development_dependency(%q<nokogiri>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rake>, ["< 10.2", ">= 0.9.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2"])
      s.add_development_dependency(%q<simplecov>, [">= 0.6.2"])
      s.add_development_dependency(%q<spork>, [">= 1.0.0.rc2"])
      s.add_development_dependency(%q<syntax>, [">= 1.0.0"])
      s.add_development_dependency(%q<bcat>, ["~> 0.6.2"])
      s.add_development_dependency(%q<kramdown>, ["~> 0.14"])
      s.add_development_dependency(%q<yard>, ["~> 0.8.0"])
      s.add_development_dependency(%q<capybara>, ["< 2.1", ">= 1.1.2"])
      s.add_development_dependency(%q<rack-test>, [">= 0.6.1"])
      s.add_development_dependency(%q<ramaze>, [">= 0"])
      s.add_development_dependency(%q<sinatra>, [">= 1.3.2"])
      s.add_development_dependency(%q<webrat>, [">= 0.7.3"])
      s.add_development_dependency(%q<mime-types>, ["< 2.0"])
      s.add_development_dependency(%q<rubyzip>, ["< 1.0"])
    else
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<diff-lcs>, [">= 1.1.3"])
      s.add_dependency(%q<gherkin>, ["~> 2.12"])
      s.add_dependency(%q<multi_json>, ["< 2.0", ">= 1.7.5"])
      s.add_dependency(%q<multi_test>, [">= 0.1.1"])
      s.add_dependency(%q<aruba>, ["= 0.5.2"])
      s.add_dependency(%q<json>, ["~> 1.7"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5.2"])
      s.add_dependency(%q<rake>, ["< 10.2", ">= 0.9.2"])
      s.add_dependency(%q<rspec>, ["~> 2"])
      s.add_dependency(%q<simplecov>, [">= 0.6.2"])
      s.add_dependency(%q<spork>, [">= 1.0.0.rc2"])
      s.add_dependency(%q<syntax>, [">= 1.0.0"])
      s.add_dependency(%q<bcat>, ["~> 0.6.2"])
      s.add_dependency(%q<kramdown>, ["~> 0.14"])
      s.add_dependency(%q<yard>, ["~> 0.8.0"])
      s.add_dependency(%q<capybara>, ["< 2.1", ">= 1.1.2"])
      s.add_dependency(%q<rack-test>, [">= 0.6.1"])
      s.add_dependency(%q<ramaze>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 1.3.2"])
      s.add_dependency(%q<webrat>, [">= 0.7.3"])
      s.add_dependency(%q<mime-types>, ["< 2.0"])
      s.add_dependency(%q<rubyzip>, ["< 1.0"])
    end
  else
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<diff-lcs>, [">= 1.1.3"])
    s.add_dependency(%q<gherkin>, ["~> 2.12"])
    s.add_dependency(%q<multi_json>, ["< 2.0", ">= 1.7.5"])
    s.add_dependency(%q<multi_test>, [">= 0.1.1"])
    s.add_dependency(%q<aruba>, ["= 0.5.2"])
    s.add_dependency(%q<json>, ["~> 1.7"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5.2"])
    s.add_dependency(%q<rake>, ["< 10.2", ">= 0.9.2"])
    s.add_dependency(%q<rspec>, ["~> 2"])
    s.add_dependency(%q<simplecov>, [">= 0.6.2"])
    s.add_dependency(%q<spork>, [">= 1.0.0.rc2"])
    s.add_dependency(%q<syntax>, [">= 1.0.0"])
    s.add_dependency(%q<bcat>, ["~> 0.6.2"])
    s.add_dependency(%q<kramdown>, ["~> 0.14"])
    s.add_dependency(%q<yard>, ["~> 0.8.0"])
    s.add_dependency(%q<capybara>, ["< 2.1", ">= 1.1.2"])
    s.add_dependency(%q<rack-test>, [">= 0.6.1"])
    s.add_dependency(%q<ramaze>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 1.3.2"])
    s.add_dependency(%q<webrat>, [">= 0.7.3"])
    s.add_dependency(%q<mime-types>, ["< 2.0"])
    s.add_dependency(%q<rubyzip>, ["< 1.0"])
  end
end
