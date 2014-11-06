require "open-uri"
require "nokogiri"
require "capybara/poltergeist"
require_relative "opening_night_page"

class ScraperHelper
  attr_reader :page
  def initialize
    session = Capybara::Session.new(:poltergeist)
    @page = OpeningNightPage.new
  end

  def open_website
    session.visit(@page.website_url)
  end

  def scrape_events_to_file
    find_current_event_month.text
    find_current_event_month.click
    write_to_file('tmp')
  end

  def find_current_event_month
    session.find(:xpath, @page.month_xpath).text
  end

  def display_all_events
    session.find(:xpath, @page.month_xpath).click
  end

  def write_to_file(filename)
    File.open("#{filename}".html, 'w') { |file| file.write(session.html) }
    File.open("#{filename}".xml, 'w') { |file| file.write(session.html) }
  end

  def all_date_nodes(xml_document)
    populate_all_nodes(xml_document, @page.date_xpath.xpath('text()'))
  end

  def all_title_nodes(xml_document)
    populate_all_nodes(xml_document, @page.title_xpath)
  end

  def all_location_nodes(xml_document)
    populate_all_nodes(xml_document, @page.location_xpath.xpath('text()'))
  end

  def populate_all_nodes(xml_document, element_xpath)
    xml_document.xpath(element_xpath)
  end

  def listify_time_nodes(doc_element)
    array_of_event_time = []
    event_time_nodes = doc_element.xpath(@page.time_xpath.xpath('text()'))
    event_time_nodes.map { |event_time_node| make_pretty_string(event_time_node) }
    event_time_nodes
  end

  def strip(str_value)
    "#{str_value}".gsub(/\s+/, " ").strip
  end

end