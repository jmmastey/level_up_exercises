## Let's Be Rational

It's your first week on the job, and you've been asked to help complete a task that a former employee left unfinished. The task was to build a class that can store numerical fractions like 1/4 and -131/27. Unfortunately your predecessor not only left out most of the requested features, but they also failed to write any tests for their software.

## Requirements

Included in this project is a partially-implemented class `Fraction` along with a couple scripts. The class is expected to work something like this:

```
x = Fraction.new(2, 5)
y = Fraction.new(1, 3)
z = x + y
puts "The sum of #{x} and #{y} is #{z}"
puts "As a float: #{z.to_f}"
puts "As JSON: #{z.to_json}"
```

Interestingly enough, `Fraction` can load a value over HTTP. Run the server and the test scripts in the project directory to see it in action:

```
$ ruby server.rb
```

Then in another terminal repeatedly run the test script:

```
$ ruby test.rb
```


Your task is to complete the implementation of `Fraction` by doing the following:

1. Implement additional functionality
  1. Add other operators: subtraction(`-`), multiplication(`*`), division(`/`)
  2. Allow for zero, one or two arguments in the initializer.
  3. It should raise an exception if initialized with non-integer arguments or if the denominator is zero.
  4. Add `to_json` that conforms with the `from_json` method already implemented
  5. Add `to_f`
2. Implement tests
  1. Write unit-tests in RSpec
  2. Test the `load` method by mocking the `http.request` call

## Notes

Yes, we know that the class `Rational` already exists in core Ruby. However the point here is to practice writing tests for your own software. This exercise is a great opportunity to practice _true_ Test-Driven-Development (TDD)! Try writing the RSpec tests first, then code your implementation to make them pass.

Feel free to add additional features to your class - there's always room for creativity in coding!
