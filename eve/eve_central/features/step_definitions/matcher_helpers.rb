require "nokogiri"

module MatcherHelpers
  class XmlMatcher
    def initialize(actual)
      @xml = Nokogiri::XML(actual)
    end

    def matches?
      @xml.any?
    end

    def with_text(text)
      @xml = @xml.select { |node| node.text.strip == text }
      self
    end

    def without_text(text)
      @xml = @xml.select { |node| node.text.strip != text }
      self
    end

    def with_xpath(xpath)
      @xml = @xml.xpath(xpath) if xpath && !xpath.empty?
      self
    end
  end
end
