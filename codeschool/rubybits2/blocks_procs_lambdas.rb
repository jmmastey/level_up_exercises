hello = Proc.new { puts "Hey!" }
hello.call

hello_lambda = lambda { puts "Hey, Lambda!" }
hello_lambda.call

tweets = ["Hey there!", "Oh hi :)"]
printer = lambda { |tweet| puts tweet }
tweets.each(&printer)

