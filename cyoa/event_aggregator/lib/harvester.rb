module Harvester
  HarvesterError = Class.new(StandardError)
  HarvesterFatalError = Class.new(HarvesterError)
end

require "harvester/event_producer"
require "harvester/html_scraper"
