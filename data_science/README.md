## Data Science

Google has just announced that it is discontinuing its popular Website Optimizer product after many successful years of operation. You are somewhat confused by this announcement, but after what they did to Wave who even knows anymore, right?

Fortunately, the company has been keeping its own statistics for website visits for quite some time, so we still have the data we need to see whether our split tests are successful. Even more fortunately, as you're the closest to having recently done a statistics class, you've been selected as the lucky individual to implement the calculations in code.

However, math is hard. So, you're going to write the Rspec tests manually to make sure that the results of your computations are accurate. You've [googled some stats for split testing](http://visualwebsiteoptimizer.com/split-testing-blog/what-you-really-need-to-know-about-mathematics-of-ab-split-testing/) and you're ready to go.

## Requirements

1. The data set is a JSON file exported from the database (because Postgres does JSON now and someone went a little overboard). You'll need to parse the input file. However, make sure the data loading is abstracted from the main calculation code.
2. For a given experiment, we're looking to calculate the conversion rate of visitors as part of a split test. We care about the following factors:
  1. The total sample size and number of conversions for each cohort
  2. The conversion rate for each cohort
  3. A 95% confidence interval for each cohort's conversion rate 
  4. A confidence level that the current leader is in fact better than random. You should use the Chi-square test for this, feel free to cheat with a [simple calculator](http://www.usereffect.com/split-test-calculator) to get your initial calculations.

## Note

You should write both the tests and the code for this exercise. Writing lots of code is the best way to get better.

## Technical Notes

### Data

On browsing the JSON file you will see that each data point consists of the following:
  * Timestamp
  * Cohort
  * Conversion Flag (True/False)

Your application will have to separate data by cohort (typically their names are A and B).

### Calculations

The quantities described in 2(i), 2(ii) and 2(iii) above will need to be computed for each cohort individually. The _sample size_ for a cohort is the total number of data points for that cohort. The _number of conversions_ counts how many of those points are conversions. The _conversion rate_ for a cohort is simply the conversion viewed as a fraction of the sample size.

Item 2(iii) _confidence interval_ may be relatively new to some. It is described using two numbers known as the _lower limit_ and _upper limit_. It basically gives a range of values inside which the true _conversion rate_ is very likely to fall. So for example, the conversion rate for a cohort might be 7%, but a _95% confidence interval_ might be something like [5%,9%]. That is to say, we are 95% confident that the true conversion rate will lie somewhere between 5% and 9%. There is simple formula to compute a 95% confidence interval using conversion rate and the sample size:

```
p = conversion rate
n = sample size
se = p * (1 - p) / n
95% confidence interval = [p - 1.96 * se, p + 1.96 * se]
```

Item 2(iv) _chi-square test_, unlike the other items, is computed once for the entire data set (not for each cohort). The chi-square test is used to determine if the cohort with the highest conversion rate is in fact a winner ... statistically speaking. You can use the [ABAnalyzer](https://rubygems.org/gems/abanalyzer) gem to do the test for you. Your application should produce a single chi-square significance number (called _p-value_).

### Writing Your Tests

An easy way to write tests for this project is to create a small (artificial) data set similar to the one provided in the JSON file. You can then do almost all the calculations in a simple spreadsheet using the formulas above. If you chose to use ABAnalyzer for the chi-square test, then you can use the provided link above to precompute the chi-square significance.

Some level-up'ers discovered that ABAnalyzer will throw an `insufficient data` error if your data set is two small. You may need a sample size of at least twenty per cohort to get it to work properly.
