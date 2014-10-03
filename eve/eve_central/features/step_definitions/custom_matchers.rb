require "nokogiri"
require "rspec/expectations"

RSpec::Matchers.define :have_xpath do |expected|
  match do |actual|
    parsed_xml = Nokogiri::XML(actual)
    parsed_xml.xpath(expected).any?
  end
end
