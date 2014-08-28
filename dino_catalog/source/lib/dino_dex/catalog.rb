module DinoDex
  require 'CSV'
  require_relative 'dinosaur.rb'
  require_relative 'importer.rb'
  require_relative '../utility/chainable.rb'

  class Catalog
    prepend ::Utility::Chainable
    attr_accessor :entries

    def initialize(*file_paths)
      @entries ||= []
      import(*file_paths)
    end

    def where(criteria, sample = entries)
      sample ||= entries
      sample.select { |entry| entry.matches_all?(criteria) }
    end

    def import(*paths)
      @entries = Catalog.load(DinoDex::Dinosaur, entries, *paths)
      [:import, :where].each do |m|
        @entries.define_singleton_method(m, &method(m))
      end
      @entries.flatten
    end

    def self.load(klass, entries, *paths)
      paths.reduce(entries) { |a, e| a + Importer.load(e, klass) }
    end
  end
end
