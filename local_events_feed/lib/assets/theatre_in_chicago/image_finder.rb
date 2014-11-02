require_relative 'event'

module TheatreInChicago
  IMAGE_REGEXP = Regexp.new('class="bblue".*img src="(http:[^"]*)".*name="PlayImage"')

  module ImageFinder
    def self.find(showings_body)
      lines = showings_body.split(/\n/);
      image_line = lines.find { |line| IMAGE_REGEXP.match(line) }      
      return unless image_line
      IMAGE_REGEXP.match(image_line).captures[0]
    end
  end
end
