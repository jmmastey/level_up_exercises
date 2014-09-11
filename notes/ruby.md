# Ruby



## Procs, Blocks, & Lambdas

A proc assigned to a variable:

```
k = Proc.new{ |x| puts x }
```

Proc.new v. lambda:

```
p = Proc.new { puts "hello" }
l = lambda { puts "hey" }
ls = -> { puts "hey s" }

p.call
l.call

```

####Lambda to block
Start with an array of tweets to print:

```
tweets = ["hey", "hi"]
```
As a block:

```
tweets.each do |t|
	puts t
end
```

Alternatively, convert to a proc with `&` turning the proc `printer` into a block:

```
printer = lambda { |t| puts t }
tweets.each(&printer)
```	

#### Passing Blocks Through
Also use `&` to turn a block into a proc so it can be assigned a parameter, so:

```
def each
	tweets.each { |t| yield t }
end
```
Can be written as:

```
def each(&block)               # block into a proc
	tweets.each(&block)        # proc back into a block
end
```


#### Symbol To Proc

Calling user method on each tweet:

```
tweets.map { |t| t.user }
```
Or, use the symbol as the method name to be called:

```
tweets.map(&:user)
```


#### Closure
Current state of local variables is preserved when a lambda is created

```
def tweet_as(user)
	lambda { |tweet| puts "#{user}: #{tweet}"
end
```

So, `colleen_tweet = tweet_as("colleensain")` 

-- resolves to -->  `lambda { |tweet| puts "colleensain: #{tweet}"` 

and we can call `colleen_tweet.call("Ruby is fun!")`


#### Procs in Action

```
[2] pry(main)> proc { |x| x+x }
=> #<Proc:0x007ff0261839e0@(pry):1>

[3] pry(main)> f = _
=> #<Proc:0x007ff0261839e0@(pry):1>
from (pry):3:in `__pry__'

[5] pry(main)> f.call 1
=> 2
```

____________________________________________________________________


## Exceptions



________________________________________________________________________



## Methods


####&-unary operator

* Almost the equivalent of calling `#to_proc` on the object


A block that is passed to the each function on the [1,2,3] Array:

```
[1,2,3].each do |x|
  puts x
end
```


# Additional Topics

inject/reduce (combine many things into one)
