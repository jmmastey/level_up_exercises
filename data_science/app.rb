#!/usr/bin/env ruby

require "colorize"
require_relative "data_querier"
require_relative "json_stat_parser"
require_relative "output_formatter"
require_relative "split_test_calculator"
require_relative "split_test_group"

class App
  def initialize
    init_lines
  end

  def main
    welcome
    data = read_data
    result = calculate_data(data)
    output_result(result)
  end

  private
  def init_lines
    @lines ||= {
      thin: "-",
      thick: "=",
      title: "*"
    }
  end

  def welcome
    puts header_line(:title).cyan
    puts "A/B Split Test".center(80).cyan
    puts header_line(:title).cyan
    puts
  end

  def header_line(type = :thin, width = 80)
    @lines[type] * width
  end

  def read_data
    parser = JSONStatParser.new
    parser.read("./source_data.json")
  end

  def calculate_data(data)
    querier = DataQuerier.new(data)
    control = SplitTestGroup.new(name: "A",
                                 conversions: querier.count_cohort_conversions("A"),
                                 views: querier.count_cohort_views("A"))
    variation = SplitTestGroup.new(name: "B",
                                   conversions: querier.count_cohort_conversions("B"),
                                   views: querier.count_cohort_views("B"))

    SplitTestCalculator.new(control_group: control,
                            variation_group: variation)
  end

  def output_result(result)
    formatter = OutputFormatter.new
    puts formatter.format(result).yellow
  end
end

App.new.main
