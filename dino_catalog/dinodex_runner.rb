#!/usr/bin/env ruby
require_relative 'dinodex_ui'
require_relative 'joes_data_parser'
require_relative 'african_data_parser'

dino_list = JoesDataParser.new.parse +
            AfricanDataParser.new.parse
DinoDexUI.new(dino_list).run
