module TheatreInChicago
  module ImageFinder
    def self.find(event_node)
      return unless image_node = find_image_node(event_node)
      image_node['src']
    end

    private

    def self.find_image_node(event_node)
      return unless image_nodes = event_node.css(".bblue img") 
      image_nodes.find { |node| node['name'] == 'PlayImage' }
    end
  end
end
