## Design Notes and Thoughts

This document will be nothing more than me periodically writing things down as I get my thoughts in order.


### Testing

A primary goal is to not unnecessarily inflate test coverage. Tests at the acceptance level (what some people still seem to incorrectly call the BDD level) should not duplicate verbatim those being done at a unit level. That being said, acceptance tests do more than just specify the elaborated requirements as business level examples. They also provide confidence that the underlying implementation is not only working in a stated context but is robust within that context. So there's a balance to deciding what elements of unit test coverage should also be stated in the context of acceptance tests.

In reality, this is the false dichotomy the industry has painted itself in. Unit tests are just another form of acceptance test when you realize that acceptance testing is an approach to testing, not a type of testing. I'll have to see how to approach this with Overlord.

The README says that it is "just an exercise of translating those requirements into working tests".

If you are using tools like Cucumber, your elaborated requirements _are_ the tests. You shouldn't be "translating" them as one of the major points of Cucumber and tools like it is to reduce sources of truth, reduce communication churn and capture communication as examples that provide a shared notion of quality. As this is, I would now have two sources of truth: the alleged "requirements" in the README and my BDD-style tests, which are -- by the logic of this example -- just "translations" of those requirements. This is exactly where BDD is going wrong in the industry and it's quite important to have that distinction.

### Implementation

* Building this with Sinatra, as opposed to Rails. We use Rails, not Sinatra. So that's ... interesting.
* Using Puma as the web server because that seems to be recommended over Unicorn, Thin, and WEBrick.
* Timer is "extra credit"? Without a timer, the bomb would explode immediately.