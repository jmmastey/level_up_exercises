require "open-uri"
require "rss"

module Harvester
  TAG_CONTENT = 'content'.freeze
  TAG_SOURCE = 'source'.freeze

  class RSSFeedHarvester
    attr_accessor :tags, :source, :callback_on_error
    attr_reader :feed_title, :feed_description, :url, :feed

    EVENT_SOURCE_TYPE = 'application/rss+xml'

    DEFAULT_ITEM_TRANSFORM = ->(_harvester, _item, _event) { true }

    DEFAULT_CALLBACK_ON_ERROR = ->(exception, harvester, rss_item) do
      $stderr.printf("%s harvester error [%s]: %s", self.class.name,
                     exception.class.name, exception.message)
    end
      
    EVENT_TO_RSS_ITEM_FIELD =
    {
      name:         :title,
      url:          :link,
      description:  :description,
      start_time:   :dc_start,
      end_time:     :dc_end
    }

    def initialize(options = {})
      @source = options[:source]
      @tags = options.fetch(:tags, [])
      @callback_on_error =
        options.fetch(:callback_on_error, DEFAULT_CALLBACK_ON_ERROR)
    end

    def create_calendar_items_from(url, &block)
      @url = url
      @callback_on_transform = block || DEFAULT_ITEM_TRANSFORM
      open(url) { |stream| process_rss_feed(stream) }
      source.last_harvest = Time.now.to_i
    end

    private

    def process_rss_feed(rss_stream)
      @feed = RSS::Parser.parse(rss_stream)
      initialize_processing_state
      feed.items.each { |item| populate_calendar(item) }
    end

    def initialize_processing_state
      @feed_title = feed.channel.title
      @feed_description = feed.channel.description
      @source ||= construct_calendar_event_source
    end

    def construct_calendar_event_source
      EventSource.where(url: url, type: EVENT_SOURCE_TYPE) ||
        EventSource.create(name: feed_title, url: url, type: EVENT_SOURCE_TYPE)
    end

    def populate_calendar(rss_item)
      return unless event = construct_event(rss_item)
      associate_event_tags(event, rss_item)
      # event_attachments?? DO WE NEED THESE??
      event.save
    rescue RuntimeError => err
      callback_on_error.(err, self, rss_item)
    end

    def construct_event(rss_item)
      event = CalendarEvent.new(event_construction_params_from_rss(rss_item))
      @callback_on_transform.call(self, rss_item, event) ? event : false
    end

    def event_construction_params_from_rss(rss_item)
      param_list = EVENT_TO_RSS_ITEM_FIELD.each_pair.map do |event, rss|
        next unless rss_field_value = rss_item.send(rss)
        [event, rss_field_value] unless rss_field_value.nil?
      end
      param_list << [:source, source]
      Hash[param_list.compact]
    end
  end
end
