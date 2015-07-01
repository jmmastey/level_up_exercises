#!/usr/bin/env ruby

require_relative 'importer'
require_relative 'dinosaur'

class DinoDex
  attr_accessor :options

  def initialize(config = {})
    @options = {
      path: config[:path] || 'data/*.csv',
      headers: true
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
end

DinoDex.new
