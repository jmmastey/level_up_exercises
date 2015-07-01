#!/usr/bin/env ruby

require_relative 'importer'

class DinoDex
  attr_accessor :path

  def initialize(path = 'data/*.csv')
    @path = path
    create_file_path
    @data = Importer.new(path)
  end

  private

  def create_file_path
    if File.extname(path).empty?
      @path = path + '/' unless path.split('').last == '/'
      @path = path + '*.csv' if File.extname(path).empty?
    end
    @path
  end
end

DinoDex.new
