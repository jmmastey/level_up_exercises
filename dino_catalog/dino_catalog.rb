#!/usr/bin/ruby

#!/usr/bin/ruby -w

require "./queriable_enumerable"

class Foo
  attr_accessor :bar
  attr_accessor :baz

  def initialize(bar, baz)
    @bar = bar
    @baz = baz
  end
end

a = QueriableEnumerable.new()
c = -1 
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")
a[c+=1] = Foo.new(c, "Next C IS #{c+1}")

a.bar(3,4,5).baz("Next C IS 2").each { |c| puts c.inspect, "\n" }
