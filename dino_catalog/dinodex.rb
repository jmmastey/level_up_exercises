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
    if File.extname(options[:path]).empty?
      @options[:path] += '/' unless options[:path].split('').last == '/'
      @options[:path] += '*.csv' if File.extname(options[:path]).empty?
    end
  end
end

DinoDex.new
