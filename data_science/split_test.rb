#!/usr/bin/env ruby

require "colorize"
require_relative "data_grouper"
require_relative "json_stat_parser"
require_relative "split_test_calculator"
require_relative "split_test_group"

class SplitTest
  LINES = {
    thin: "-",
    thick: "=",
    title: "*"
  }

  def main
    welcome
    data = read_data
    result = calculate_data(data)
    output_result(result)
  end

  private

  def welcome
    puts header_line(:title).cyan
    puts "A/B Split Test".center(80).cyan
    puts header_line(:title).cyan
    puts
  end

  def header_line(type = :thin, width = 80)
    LINES[type] * width
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
    puts result.to_s.yellow
  end
end

SplitTest.new.main
