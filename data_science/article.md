https://vwo.com/blog/what-you-really-need-to-know-about-mathematics-of-ab-split-testing/#pgITV80ISo2dAh7V.99

## What you really need to know about mathematics of A/B split testing

Posted in A/B Split Testing on January 26, 2010

Recently, I published an A/B split testing case study where an eCommerce store
reduced bounce rate by 20%. Some of the blog readers were worried about
statistical significance of the results. Their main concern was that a value of
125-150 visitors per variation is not enough to produce reliable results. This
concern is a typical by-product of having superficial knowledge of statistics
which powers A/B (and multivariate) testing. I’m writing this post to provide
an essential primer on mathematics of testing so that you never jump to a
conclusion on reliability of a test results simply on the basis of number of
visitors.


### What Exactly Goes Behind A/B Split Testing?

Imagine your website as a black box containing balls of two colors (red and
green) in unequal proportions. Every time a visitor arrives on your website he
takes out a ball from that box: if it is green, he makes a purchase. If the
ball is of red color, he leaves the website. This way, essentially, that black
box decides the conversion rate of your website.

A key point to note here is that you cannot look inside the box to count the
number of balls of different colors in order to determine true conversion rate.
You can only estimate the conversion rate based on different balls you see
coming out of that box. Because conversion rate is an estimate (or a guess),
you always have a range for it; never a single value. For example,
mathematically, the way you describe a range is:

“Based on the information I have, 95% of the times conversion rate of my
website ranges from 4.5%-7%.”

As you would expect, with more number of visitors, you get to observe more
number of balls. Hence, your range gets narrower and your estimate starts
approaching true conversion rate.


### The Maths of A/B Split Testing

Mathematically, the **conversion rate** is represented by a **binomial random
variable**, which is a fancy way of saying that it can have two possible values:

1. conversion
2. non-conversion

Let’s call this variable as `p`. Our job is to estimate the value of `p` and
for that we do `n` trials (or observe `n` visits to the website). After observing
those `n` visits, we calculate how many visits resulted in a conversion. That
percentage value (which we represent from 0 to 1 instead of 0% to 100%) is the
conversion rate of your website.

Now imagine that you repeat this experiment multiple times. It is very likely
that, due to chance, every single time you will calculate a different value of
p. Having all (different) values of `p`, you get a range for the conversion
rate (which is what we want for next step of analysis). To avoid doing repeated
experiments, statistics has a neat trick in its toolbox. There is a concept
called standard error, which tells how much deviation from average conversion
rate (`p`) can be expected if this experiment is repeated multiple times.
Smaller the deviation, more confident you can be about estimating true
conversion rate. For a given conversion rate (`p`) and number of trials (`n`),
standard error is calculated as:

    Standard Error (SE) = Square root of (p * (1-p) / n)

Without going much into details, to get 95% range for conversion rate multiply
the standard error value by 2 (or 1.96 to be precise). In other words, you can
be sure with 95% confidence that your true conversion rate lies within this
range:

    p % ± 2 * SE

(In Visual Website Optimizer, when we show conversion rate range in reports, we
show it for 80%, not 95%. So we multiply standard error by 1.28)


### What Does it Have to do With Reliability of Results?

In addition to calculating conversion rate of the website, we also calculate a
range for its variations in an A/B split test. Because we have already
established (with 95% confidence) that true conversion rate lies within that
range, all we have to observe now is the overlap between conversion rate range
of the website (control) and its variation. If there is no overlap, the
variation is definitely better (or worse if variation has lower conversion
rate) than the control. It is that simple.

As an example, suppose control conversion rate has a range of 6.5% ± 1.5% and a
variation has range of 9% ± 1%. In this case, there is no overlap and you can
be sure about the reliability of results.


### Do You Call All That Math Simple?

Okay, not really simple but it is definitely intuitive. To save the trouble of
doing all the math by yourself, either use a tool like Visual Website Optimizer
which automatically does all the number crunching for you. Or, if you are doing
a test manually (such as for Adwords), use our free A/B split test significance
calculator.


### So, What is the Take-Home Lesson Here?

Always, always, always use an A/B split testing calculator to determine
significance of results before jumping to conclusions. Sometimes you may
discount significant results as non-significant solely on the basis of number
of visitors (such as you may do for this case study). Sometimes you may think
results are significant due to large number of visitors when in fact they are
not (such as here). You really want to avoid both scenarios, don’t you?
