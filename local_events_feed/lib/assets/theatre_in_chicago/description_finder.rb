require 'active_support/all'

module TheatreInChicago
  module DescriptionFinder
    def self.find(event_node)
      return unless description_node = event_node.at("meta[name='description']")
      description = description_node['content']
      description.squish
    end
  end
end
