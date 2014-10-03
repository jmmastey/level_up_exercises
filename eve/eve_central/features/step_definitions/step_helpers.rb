require "nokogiri"

def parse_xml(xml)
  Nokogiri::XML(xml)
end
