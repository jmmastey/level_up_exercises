require "nokogiri"
require "rspec"

RSpec::Matchers.define :have_xpath do |xpath|
  match do |actual|
    actual_xml = Nokogiri::XML(actual)
    matching_xml = actual_xml.xpath(xpath)

    matching_xml.any? &&
      (!@expected_text || matching_xml.text == @expected_text)
  end

  chain :with_text do |text|
    @expected_text = text
  end
end
