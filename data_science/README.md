## Data Science

Google has just announced that it is discontinuing its popular Website Optimizer product after many successful years of operation. You are somewhat confused by this announcement, but after what they did to Wave who even knows anymore, right?

Fortunately, the company has been keeping its own statistics for website visits for quite some time, so we still have the data we need to see whether our split tests are successful. Even more fortunately, as you're the closest to having recently done a statistics class, you've been selected as the lucky individual to implement the calculations in code.

However, math is hard. So, you're going to write the Rspec tests manually to make sure that the results of your computations are accurate. You've [googled some stats for split testing](http://visualwebsiteoptimizer.com/split-testing-blog/what-you-really-need-to-know-about-mathematics-of-ab-split-testing/) and you're ready to go.

## Requirements

1. The data set is a JSON file exported from the database (because Postgres does JSON now and someone went a little overboard). You'll need to parse the input file. However, make sure the data loading is abstracted from the main calculation code.
2. For a given experiment, we're looking to calculate the conversion rate of visitors as part of a split test. We care about the following factors:
  * Total sample size and number of conversions for each part of the test.
  * Percentage of conversion (including error bars) with a 95% confidence.
  * Confidence level that the current leader is in fact better than random. You should use the Chi-square test for this, feel free to cheat with a [simple calculator](http://www.usereffect.com/split-test-calculator) to get your initial calculations.

## Note

You should write both the tests and the code for this exercise. Writing lots of code is the best way to get better.
