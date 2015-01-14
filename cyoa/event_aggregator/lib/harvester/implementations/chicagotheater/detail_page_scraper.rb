require "active_support/all"
require "chronic"

module Harvester
  class DetailPageScraper
    include Harvester::HtmlScraper::HtmlScraperStrategy

    def run
      extract_event_information
      create_event_family
    end

    private

    attr_accessor :event_times, :thru_date

    def extract_event_information
      new_event_attributes.merge!({
        title: html_node_text("#titleP strong.detailhead"),
        location: html_node_text("#theatreName a"),
        description: html_node_text("#theatreName + p + p"),
        host: find_presenter,
        image_url: find_image,
      })
      enumerate_event_times
    end

    def html_node_text(css_selector, root = document)
      document.css(css_selector).first.text.strip
    rescue
      nil
    end

    def find_presenter
      find_node_text("#theatreName + p + p + span", /(?<=Presented by )(.*)/)
    end

    def find_node_text(css, pattern, root = document)
      root.css(css).first.traverse do |node|
        (match, _waste) = *node.text.match(pattern)
        return match if match
      end
      nil
    end

    def enumerate_event_times
      find_thru_date
      @event_times = extract_event_times.flatten.compact
    end

    def find_thru_date
      selector = "table table table p.detailbody.bottomPad"
      date_spec = find_node_text(selector, /(?<=Thru - )(.*)/)
      @thru_date = date_spec ? Chronic.parse(date_spec) : Date.today + 30
    end

    def extract_event_times
      times = document.css("table.daysTable tr").map do |node|
        date_spec, times_list = node.css("td").map { |td| td.text.strip }
        convert_to_times(date_spec, times_list || '')
      end
    end

    def convert_to_times(date_spec, times_list)
      time_specs = times_list.split('&').map(&:strip)
      day_of_week = date_spec.match(/(?:sun|mon|tues|wednes|thurs|fri|satur)day(?=s)/i)
      dates = day_of_week ? dates_by_day_of_week(day_of_week[0]) : [date_spec]
      dates.product(time_specs).map do |(date, time_spec)|
        Chronic.parse("#{date} #{time_spec}")
      end
    end

    def dates_by_day_of_week(day_of_week)
      day = day_of_week.downcase.to_sym
      first_day = Date.today.beginning_of_week +
                  DateAndTime::Calculations::DAYS_INTO_WEEK[day]
      (first_day..thru_date).step(7).to_a
    end

    def create_event_family
      event_times.each do |event_time|
        new_event_attributes[:start_time] = event_time
        new_event_attributes[:end_time] = event_time + 1.hour
        event_producer.yield_event
      end
    end

    def find_image
      img = document.css("td.bblue img")[0]
      img.nil? ? nil : img['src']
    end
  end
end
