#!/usr/bin/env ruby

require_relative 'importer'
require_relative 'dinosaur'

class DinoDex
  attr_accessor :options

  def initialize(config = {})
    @options = {
      path: config[:path] || 'data/*.csv',
      headers: true,
      header_converters: config[:header_converters] || header_normalize,
    }
    create_file_path
    @data = Importer.new(options, Dinosaur)
  end

  private

  def create_file_path
    return unless File.extname(options[:path]).empty?
    @options[:path] += '/' unless ends_with_slash?(options[:path])
    @options[:path] += '*.csv' if no_extension?(options[:path])
  end

  def no_extension?(path)
    File.extname(path).empty?
  end

  def ends_with_slash?(path)
    path.split('').last == '/'
  end

  def header_normalize
    lambda do |header|
      header.downcase!
      rename_columns(header)
      header.to_sym
    end
  end

  def rename_columns(header)
    header.gsub!('genus', 'name')
    header.gsub!('weight_in_lbs', 'weight')
    header.gsub!('walking', 'movement')
    header.gsub!('carnivore', 'diet')
  end
end

DinoDex.new
