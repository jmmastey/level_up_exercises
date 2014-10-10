require "nokogiri"

module EveCentral
  module XmlHelpers

    private

    def get_node_content(parent, xpath)
      parent.xpath(xpath).first.content
    end

    def get_node_date(parent, xpath)
      Date.parse(get_node_content(parent, xpath))
    end

    def get_node_datetime(parent, xpath, options = {})
    end

    def get_node_float(parent, xpath)
      get_node_content(parent, xpath).to_f
    end

    def get_node_int(parent, xpath)
      get_node_content(parent, xpath).to_i
    end
  end
end
