
# #+TITLE: Blocks, Procs, and Lambdas
# #+SETUPFILE: ../defaults.org

# In past episodes I've been tossing around words like "proc" and
# "lambda" interchangeably. I figure it probably behooves me to clarify
# what these terms mean, as well as where blocks fit into the picture.

# In Ruby we can create an anonymous chunk of code by calling
# =Proc.new=. This gives us a Proc object, which we can then assign to
# variables and pass around. When we want the code to execute, we send
# it the =#call= method.

greeter = Proc.new do |name|
  puts "Hello, #{name}"
end
greeter                       # => #<Proc:0x0000000410cd00@-:1>
greeter.call("Ylva")
# >> Hello, Ylva

# There's a shortcut for this: the =Kernel#proc= method.

greeter = Proc.new do |name|
  puts "Hello, #{name}"
end
greeter                       # => #<Proc:0x0000000312bd00@-:1>
greeter.call("Ebba")
# >> Hello, Ebba

# There are also a couple of shortcuts for the =#call= method. We can
# substitute square brackets, or use a dot followed by parentheses.

greeter = proc do |name|
  puts "Hello, #{name}"
end
greeter["Kashti"]
greeter.("Josh")
# >> Hello, Kashti
# >> Hello, Josh

# There's another =Kernel= method for creating =Proc= objects, called
# =lambda=. The objects it generates seem, at first, to be identical to
# the objects created by =proc=, except that the lambda version adds the
# word "lambda" when inspected. They both execute when called.

# In fact, the two versions /are/ very similar. One difference is that
# the lambda version is pickier about arguments. Let's try to pass an
# extra argument to both varieties and see what happens.

greeter_p = proc do |name|
  puts "Hello, #{name}"
end
greeter_l = lambda do |name|
  puts "Hello, #{name}"
end

greeter_p                       # => #<Proc:0x0000000338efe8@-:1>
greeter_l                       # => #<Proc:0x0000000338efc0@-:4 (lambda)>
greeter_p.call("Lily")
greeter_l.call("Stacey")
# >> Hello, Lily
# >> Hello, Stacey

greeter_p = proc do |name|
  puts "Hello, #{name}"
end
greeter_l = lambda do |name|
  puts "Hello, #{name}"
end

greeter_p.call("Ylva", "Brighid")
greeter_l.call("Kashti", "Aodhan")
# ~> -:5:in `block in <main>': wrong number of arguments (2 for 1) (ArgumentError)
# ~>    from -:9:in `call'
# ~>    from -:9:in `<main>'
# >> Hello, Ylva

# The basic =Proc= just throws away extra arguments, whereas the lambda
# version reports an error.

# Another, more subtle difference lies in how they handle the =return=
# statement. Let's write some code to demonstrate. We write a method
# which instantiates a proc and a lambda. Both the proc and the lambda
# will simply print some text and then return. We then execute first the
# lambda, followed by the proc. Finally, we output some more text.

def context
  l = lambda do 
    puts "In lambda"
    return
    puts "After return"
  end

  p = proc do
    puts "In proc"
    return
    puts "After return"
  end

  l.call
  p.call

  puts "End of method"
end

context
# >> In lambda
# >> In proc

# When we execute this method, we can see that the first line of both
# the proc and the lambda were executed. Not surprisingly, the last lines
# of both proc and lambda were skipped, because of the return statement
# preceding them.

# The surprising thing, though, is that the last line of the =context=
# method was never executed. This is because while the =return=
# statement inside the lambda simply ended the execution of the lambda
# itself, the =return= statement inside the proc actually ended
# execution of the /containing method/. The proc retained a reference to
# the execution context, or /binding/ that it was defined in, and the
# =return= acted as if it were invoked within that context.

# There is also an extra short form for writing lambdas, which is
# sometimes referred to as "stabby lambda" syntax.

greeter_l = ->(name) {
  puts "Hello, #{name}"
}

greeter_l                       # => #<Proc:0x000000031fba50@-:1 (lambda)>

# Note that this syntax lets us surround the arguments to the lambda in
# familiar method-style parentheses, instead of vertical pipes.

# You may be wondering at this point, how to choose between proc and
# lambda for creating anonymous hunks of code that can be passed around
# and then executed. My recommendation: stick with =lambda=, until you
# run into a specific reason /not/ to use it.

# It is often convenient to write methods which accept a single =Proc=
# as one of their arguments. For instance, here's a method which calls
# the given proc on each of a list of names.

def each_child(visitor)
  visitor.call("Lily")
  visitor.call("Josh")
  visitor.call("Kashti")
  visitor.call("Ebba")
  visitor.call("Ylva")
end

# Callers can pass in whatever code they want to be executed once for
# each name.

each_child(->(name){ puts "Hello, #{name}!" })
# >> Hello, Lily!
# >> Hello, Josh!
# >> Hello, Kashti!
# >> Hello, Ebba!
# >> Hello, Ylva!

# This pattern, of a method which has a single argument which is
# expected to be a =Proc=, turns out to be so common that Ruby gives us
# a special syntax for it. And that's essentially what blocks are. Every
# Ruby method can implicitly receive a proc argument, which is called
# using the =yield= keyword.

def each_child
  yield "Lily"
  yield "Josh"
  yield "Kashti"
  yield "Ebba"
  yield "Ylva"
end

each_child do |name|
  puts "Hello, #{name}!"
end
# >> Hello, Lily!
# >> Hello, Josh!
# >> Hello, Kashti!
# >> Hello, Ebba!
# >> Hello, Ylva!

# If we want, we can even reference the block argument as a proc object,
# by prefacing a parameter name with an '&':

def each_child(&visitor)
  puts visitor.inspect
  visitor.call("Lily")
  visitor.call("Josh")
  visitor.call("Kashti")
  visitor.call("Ebba")
  visitor.call("Ylva")
end

each_child do |name|
  puts "Hello, #{name}!"
end
# >> #<Proc:0x000000038775a0@-:10>
# >> Hello, Lily!
# >> Hello, Josh!
# >> Hello, Kashti!
# >> Hello, Ebba!
# >> Hello, Ylva!
