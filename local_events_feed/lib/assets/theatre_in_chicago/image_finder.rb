module TheatreInChicago
  module ImageFinder
    def self.find(event_node)
      find_image_node(event_node)['src']
    end

    private

    def self.find_image_node(event_node)
      event_node.at_css(".bblue img [name=PlayImage]")
    end
  end
end
