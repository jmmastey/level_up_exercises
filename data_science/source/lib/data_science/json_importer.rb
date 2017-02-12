require 'json'

module DataScience
  class JSONImporter < Importer
    OPTIONS = { symbolize_names: true }

    def self.read(input_file)
      JSON.parse(super, OPTIONS)
    end
  end
end
