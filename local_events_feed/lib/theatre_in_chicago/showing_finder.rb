require_relative 'date_list_showing_parser'
require_relative 'dows_showing_parser'

module TheatreInChicago

  module ShowingFinder
    @@showing_parsers = [ TheatreInChicago::DateListShowingParser,
                          TheatreInChicago::DowsShowingParser ]

    def self.find(event_node)
      showings = []
      @@showing_parsers.each do |parser|
        showings.concat(parser.new(event_node).showings)
      end
      showings
    end
  end
end
