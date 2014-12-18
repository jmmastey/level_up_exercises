module Harvester
  class EventProducer

    DEFAULT_CALLBACK_ON_CREATE = ->(_harvester, event) { event.save }

    attr_reader :event_data_context
    attr_accessor :event_source

    def initialize
      setup_processing_context(nil)
    end

    def create_calendar_items_from(data_collector, &block)
      @callback_on_create = block || DEFAULT_CALLBACK_ON_CREATE
      @data_collector = data_collector
      setup_processing_context(data_collector)
      data_collector.run(self)
    end

    def yield_event
      event = find_or_create_calendar_event
      yield event if block_given?
      @callback_on_create.call(self, event)
    end

    def setup_event_source(options)
      @event_source ||= EventSource.find_or_create_by(options)
    end

    def self.create_calendar_items_from(data_collector, &block)
      new.create_calendar_items_from(data_collector, &block)
    end

    private

    attr_accessor :data_collector

    def setup_processing_context(data_collector)
      @event_data_context = { event_attributes: {} }
    end

    def new_event_attributes
      final_attributes = { event_source: event_source }
      event_data_context[:event_attributes].merge(final_attributes)
    end

    def find_or_create_calendar_event
      CalendarEvent.find_by(event_hash: new_event_hash) ||
        CalendarEvent.new(new_event_attributes)
    end

    def new_event_hash
      search_attrs =
        new_event_attributes.merge(source_event_name: event_source.name)
      CalendarEvent.event_hash(search_attrs)
    end
  end
end
