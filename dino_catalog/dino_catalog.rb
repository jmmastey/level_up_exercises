#!/usr/bin/ruby

#!/usr/bin/ruby -w

require "./object_set"

class TestSet
  include ObjectSet

  def initialize
    @items = []
  end

  def []=(int, val)
    @items[int] = val
  end

  def each
    @items.each { |item| yield item }
  end
end

class Foo
  attr_accessor :bar
  attr_accessor :baz

  def initialize(bar, baz)
    @bar = bar
    @baz = baz
  end
end

a = TestSet.new
c = -1 
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")

a.bar(3,4,5).each { |c| puts c.inspect, "\n" }
