require 'json'

module Service
  class JsonParser
    def self.parse(file)
      unless file_exists?(file)
        raise "The file = '#{file}' could not be located"
      end
      file = File.read(file)
      JSON.parse(file, :symbolize_names => true)
    end

    def self.file_exists?(file)
      File.exists?(file)
    end

    def self.file_empty?(file)
      File.zero?(file)
    end
  end
end
