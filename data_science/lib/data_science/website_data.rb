module DataScience
  class WebsiteData
    require 'json'

    attr_reader :data

    def initialize(filename)
      @filename = filename
      @data = convert_data
    end

    def sample_size(cohort)
      data.count { |entry| entry.cohort == cohort }
    end

    def conversion_count(cohort)
      data.count { |entry| entry.cohort == cohort && entry.converted }
    end

    def non_conversion_count(cohort)
      data.count { |entry| entry.cohort == cohort && !entry.converted }
    end

    def format_for_analyzer
      values = {}
      values[:a] = { converted: conversion_count('A'),
                     not_converted: non_conversion_count('A') }
      values[:b] = { converted: conversion_count('B'),
                     not_converted: non_conversion_count('B') }
      values
    end

    private

    Entry = Struct.new(:date, :cohort, :converted)

    def convert_data
      parse_data.inject([]) do |a, e|
        a << Entry.new(e["date"], e["cohort"], e["result"] == 1 ? true : false)
      end
    end

    def parse_data
      JSON.parse(File.read(@filename))
    end
  end
end
