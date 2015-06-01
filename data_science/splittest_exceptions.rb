module Exceptions
  class NoDataSourceError < StandardError
    def message
      "No data source (file) was specified"
    end
  end

  class FileNotFoundError < StandardError
    def message
      "File not found"
    end
  end

  class InvalidDataFormatError < StandardError
    def initialize(missing_key = nil)
      @missing_key = missing_key
    end

    def message
      error = "Invalid data format"
      error += ": " + @missing_key + " key is missing" unless @missing_key.nil?
      error
    end
  end

  class InsufficientDataError < StandardError
    def initialize(message = '')
      @message = message
    end

    def message
      @message
    end
  end
end
