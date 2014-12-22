require "rspec"
require_relative "matcher_helpers"

RSpec::Matchers.define :have_xpath do |xpath|
  match do |actual|
    matcher = MatcherHelpers::XmlMatcher.new(actual)
    matcher.with_xpath(xpath)
    matcher.with_text(@expected_text) if @expected_text
    matcher.without_text(@unexpected_text) if @unexpected_text
    matcher.with_value(@comparator, @compare_value) if match_value?

    matcher.matches?
  end

  chain :with_text do |text|
    @expected_text = text unless text.nil? || text.empty?
  end

  chain :without_text do |text|
    @unexpected_text = text unless text.nil? || text.empty?
  end

  def match_value?
    @comparator && @compare_value
  end
end
