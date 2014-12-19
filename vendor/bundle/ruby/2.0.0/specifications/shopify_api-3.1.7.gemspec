# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "shopify_api"
  s.version = "3.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shopify"]
  s.date = "2013-11-25"
  s.description = "The Shopify API gem allows Ruby developers to programmatically access the admin section of Shopify stores. The API is implemented as JSON or XML over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation."
  s.email = "developers@jadedpixel.com"
  s.executables = ["shopify"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["bin/shopify", "LICENSE", "README.rdoc"]
  s.homepage = "http://www.shopify.com/partners/apps"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "ShopifyAPI is a lightweight gem for accessing the Shopify admin REST web services"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activeresource>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<thor>, [">= 0.14.4"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<activeresource>, [">= 3.0.0"])
      s.add_dependency(%q<thor>, [">= 0.14.4"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<activeresource>, [">= 3.0.0"])
    s.add_dependency(%q<thor>, [">= 0.14.4"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
