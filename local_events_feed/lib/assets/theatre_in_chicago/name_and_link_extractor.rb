require_relative 'event'

module TheatreInChicago
  ROOT_LINK = 'http://www.theatreinchicago.com'
  EVENT_NAME_REGEXP = Regexp.new('<a href="([^"]*)" class="detailhead"[^>]*><strong>([^<]*)</strong></a>');

  module NameAndLinkExtractor
    def self.extract(line, event)
      return unless EVENT_NAME_REGEXP.match(line)
      captures = EVENT_NAME_REGEXP.match(line).captures
      event.link = "#{ROOT_LINK}#{captures[0]}"
      event.name = captures[1]
      event
    end

    def self.complete?(event)
      event.name.present? && event.link.present?
    end
  end
end
