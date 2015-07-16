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

### Initial Spec Workshop

I started with the feature-level tests. In doing so, I started with the statements from the README, largely as if I was having a discussion with the client. In talking with my client, getting the minimum viable product up and working seemed important. What I'm going to do here is introduce aspects of the README as if they had come up in conversation. We started with this:

* "The bomb interface should include a field to type in an activation / deactivation code."

That, however, led me to realize that just having a field by itself means nothing unless there is something viable to type into it. What really matters it the behavior, which means I need to focus on what will occur when this field is used. So I talked with my user and we first brought up some interface aspects:

* "The bomb interface should include a field to type in an activation / deactivation code."
* "The bomb interface should include an indicator of the activation state of the bomb."

I now had some idea of how the client was visualizing the bomb application working but I wasn't mired in implementation details. So I started in on the behavior:

* "When the bomb is first booted, it should not be activated."

So I was able to make the simplest possible implementation: initially just a Sinatra route that served up text. And then a bare-bones web page that contained that exact text. So now what? I could just keep designing more Cucumber specs or I could start getting into actual code. However, going with the thrust of test-first I didn't know the code I wanted yet since we hadn't fleshed out the design. So we went back to one of our initial statements:

* "A new bomb can be activated with a valid activation code."

This begs the question of what "valid" means.

* "Valid activation codes are only numeric."
* "Valid activation codes are exactly four digits."

But where do I do this? In order to get the initial test to pass, I created some web pages and some JavaScript. That was all that was needed to provide a simple form and handle a click. Should I put the validation in the JavaScript as well? At this point, I could start constructing this entire app in JavaScript -- so why do I even need any Ruby code at all, beyond the bare minimum of Sinatra providing the routing? So far nothing in the design was calling out the need for anything beyond HTML and JS. At this point, however, "valid" was not called out in the spec file so anything was valid.
