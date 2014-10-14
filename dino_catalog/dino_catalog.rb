#!/usr/bin/ruby -w

require "pry"

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(this_dir) unless $LOAD_PATH.include?(this_dir)

require "filtering_enumerable"
require "dinodex"
require "dinodex/csv_loader"

q = QueriableEnumerable.new
l = Dinodex::CSVLoader.new("dinodex.csv")
#l = Dinodex::CSVLoader.new("african_dinosaur_export.csv")
#Dinodex::CSVLoader.load("dinodex.csv") { |d| puts d.inspect }
l.load { |d| q << d }

q.match(:diet, 'insectivore').each { |d| puts "foo" }
q.each { |d| puts d.full_description }
#
#class Foo
#  attr_accessor :bar
#  attr_accessor :baz
#
#  def initialize(bar, baz)
#    @bar = bar
#    @baz = baz
#  end
#end
#
#a = QueriableEnumerable.new()
#c = -1 
#a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
#a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
#a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
#a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
#a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
#a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
#a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
#
##a.bar(:match, 3,4, 5).each { |c| puts c.inspect, "\n" }
#a.bar(:between, 2,10).each { |c| puts c.inspect, "\n" }
#
##.baz("Next C IS 2").each { |c| puts c.inspect, "\n" }
