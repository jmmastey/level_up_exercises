require 'json'

  
  class Parser
    
    def initialize(input)
      @file = input
    end

    def exists?
      true if File.exist?(@file)
    end

    def parse
      JSON.parse(File.read(@file))
    end
  end
