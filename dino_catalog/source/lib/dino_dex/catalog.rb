module DinoDex

  require "CSV"
  require_relative "importer.rb"
  require_relative "../utility/chainable.rb"
  require_relative 'dinosaur.rb'

  class Catalog
    prepend ::Utility::Chainable
    attr_accessor :entries
    
    def initialize(*file_paths)
      import(*file_paths)
    end

    def where(criteria, sample = entries)
      sample ||= entries
      sample.select{ |entry| entry.matches_all?(criteria) }
    end

    def import(*file_paths)
      @entries ||= []
      @entries = file_paths.inject(@entries){ |results, f| results = results + Importer.load(f, DinoDex::Dinosaur) }
      [:import, :where].each{|m| @entries.define_singleton_method(m, &method(m)) }
      @entries.flatten
    end

  end

end