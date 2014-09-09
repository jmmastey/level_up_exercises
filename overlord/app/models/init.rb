# File init.rb
require 'data_mapper'

require_relative 'bomb'
require_relative 'wire'

DataMapper.finalize
DataMapper::Model.raise_on_save_failure = true