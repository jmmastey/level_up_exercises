require_relative 'bomb'
require_relative 'wire'
require 'data_mapper'

DataMapper.finalize
configure :test do
  DataMapper.auto_migrate!
end
DataMapper::Model.raise_on_save_failure = true
