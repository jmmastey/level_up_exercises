require 'csv'
require 'terminal-table'
require_relative 'catalog'

Catalog.new(ARGV[0]).run