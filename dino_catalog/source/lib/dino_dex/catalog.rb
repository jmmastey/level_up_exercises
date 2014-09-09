module DinoDex
  require_relative 'common.rb'
  require_relative 'dinosaur.rb'
  require_relative 'importer.rb'
  require_relative '../utility/attr_wrappable.rb'

  class Catalog
    include ::DinoDex::Common
    include ::Utility::Wrappable

    attr_accessor :entries

    attr_wrappable :entries do
      [:import, :where].inject(super()) do |a, e|
        add_chainables(a, [e], &method(e))
      end
    end

    attr_wrappable :where do |criteria, sample = nil, this = self|
      results = super(criteria, sample)
      hook = proc { |hash| this.where(hash, results) }
      add_chainables(results, [:where, :with, :and], &hook)
    end

    def initialize(klass, *paths)
      @entries ||= []
      @entry_klass = klass
      import(*paths) unless paths.empty?
    end

    def import(*paths)
      @entries = Catalog.load(@entry_klass, entries, *paths)
      entries.flatten
    end

    def where(criteria, sample = nil)
      sample ||= entries
      sample.select { |entry| entry.matches_all?(criteria) }
    end

    def self.load(klass, entries, *paths)
      paths.inject(entries) { |a, e| a + Importer.import(e, klass) }
    end

    private

    def add_chainables(object, aliases, &block)
      object.instance_exec(aliases, block) do |a, b|
        a.each { |i| define_singleton_method(i, &b) }
        self
      end
    end
  end
end
