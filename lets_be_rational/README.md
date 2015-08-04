## Let's Be Rational

It's your first week on the job, and you've been asked to help complete a task that a former employee left unfinished. The task was to build a class that can store numerical fractions like 1/4 and -131/27. Unfortunately your predecessor not only left out most of the requested features, but they also failed to write any tests for their software.

## Requirements

Included in this project is a partially-implemented class `Fraction`. The class is expected to work something like this:

```
x = Fraction.new(2, 5)
y = Fraction.new(1, 3)
z = x + y
puts "The sum of #{x} and #{y} is #{z}"
```

Your task is to complete the implementation of `Fraction` by doing the following:

1. Implement additional functionality
  1. Add other operators: subtraction(`-`), multiplication(`*`), division(`/`)
  2. Allow for zero, one or two arguments in the initializer.
  3. It should raise an exception if initialized with non-integer arguments or if the denominator is zero.
  3. Add `from_json`, `to_json`
2. Write unit-tests in RSpec

## Notes

This exercise is a great opportunity to practice _true_ Test-Driven-Development (TDD)! Try writing the RSpec tests first, then code your implementation to make them pass.

Feel free to add additional functionality to your class - there's always room for creativity in coding!
