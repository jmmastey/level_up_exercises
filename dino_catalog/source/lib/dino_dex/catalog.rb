module DinoDex
  require_relative 'common.rb'
  require_relative 'dinosaur.rb'
  require_relative 'importer.rb'
  require_relative '../utility/chainable.rb'

  class Catalog
    include ::DinoDex::Common
    include ::Utility::Chainable
    attr_chainable :entries

    def initialize(*paths)
      @entries ||= []
      import(*paths)
    end

    def import(*paths)
      @entries = Catalog.load(DinoDex::Dinosaur, entries, *paths)
      [:import, :where].each do |m|
        @entries.define_singleton_method(m, &method(m))
      end
      @entries.flatten
    end

    def self.load(klass, entries, *paths)
      paths.inject(entries) { |a, e| a + Importer.import(e, klass) }
    end
  end
end
