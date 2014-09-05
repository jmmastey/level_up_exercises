# File wire.rb

class Wire
  include DataMapper::Resource

  property :id, Serial
  property :color, String, :unique => true, :required => true
  property :detonates, Boolean, :required => true, :default => true
end