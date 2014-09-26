#!/usr/bin/env ruby

require "colorize"
require_relative "data_grouper"
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
    groups = create_groups(data)
    SplitTestCalculator.new(*groups)
  end

  def create_groups(data)
    grouper = DataGrouper.new
    grouper.create_groups(data)
  end

  def output_result(result)
    formatter = OutputFormatter.new
    puts formatter.format(result).yellow
  end
end

App.new.main
