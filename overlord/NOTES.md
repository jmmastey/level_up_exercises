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

### Activating the Bomb

* "A new bomb can be activated with a valid activation code."

This begs the question of what "valid" means.

* "Valid activation codes are only numeric."
* "Valid activation codes are exactly four digits."

This also led to the display:

* "A bomb that is activated will display it is active."
* "A bomb will indicate if it received an inaccurate activation code."

But where do I do this? In order to get the initial test to pass, I created some web pages and some JavaScript. That was all that was needed to provide a simple form and handle a click. Should I put the validation in the JavaScript as well? At this point, I could start constructing this entire app in JavaScript -- so why do I even need any Ruby code at all, beyond the bare minimum of Sinatra providing the routing? So far nothing in the design was calling out the need for anything beyond HTML and JS. At this point, however, "valid" was not called out in the spec file so anything was valid.

### Deactivating the Bomb

The next user session started with another critical piece of the bomb: being able to shut it down. 

* "Once the bomb is active, a correct deactivation code will make the bomb inactive."
* "A bomb will indicate if it is inactive."
* "A bomb will indicate if it received an inaccurate deactivation code."

### Manifest Test and Data Conditions

What was clear was that the test specs did not state certain things, except implicitly. For example, while we now had tests talking about valid and invalid codes, it was not necessarily clear that what "valid" meant was four numeric characters. That could be gleaned but nothing outright said it. It was uncertain at this point, however, how best to make this information clearer in the test specs particularly since the originally stated goal was to make sure that there was not too much duplication of BDD and TDD style tests.

My current test specs, on the other hand, do allow for a lot of flexibility for the underlying implementation. But then my scenario outlines stick out like a sore thumb in that they encode the specific behavior.

### Modelling the Bomb

One thing that became obvious: we're starting to get into state here. The bomb is now no longer just being displayed but is having a specific state that needs to be set and retrieved. That implied we are starting to get into a model. It seemed like we were close to actually coding something.

From a design perspective, it's not a "bomb" that is active or inactive but rather the trigger for the bomb. That trigger happens to be one component of a working bomb. This suggests a bomb page, which needs to be connected to via a route. And that route is going to call some functionality that lets me create my model instance.

First step was writing the BDD style tests. And that made me note that, up to this point, I have been using scenarios that say how the bomb "displays." So it will "display inactive" or "display active". But that's not the same as saying that it will _be_ active or inactive.

Even in starting the RSpec tests, it's clear they will duplicate the Cucumber tests. On the other hand, though, the Cucumber tests drove the design of the view. The RSpec tests will drive the design of the model. Since the view is ultimately representing the model, the fact that the tests overlap should not be surprising.

### Default Codes

As of now, my code feels disjointed. I have two checks for what a valid code means: one in the JS that the view uses and one in the model. However, this is the same check being applied twice. By the time the `valid?` method in the model gets run, I already know the code must be valid because of the JavaScript.

I'm not sure how to handle that better at this point. Then again, I'm not a web app developer nor do I have a desire to be. Nor, in fact, was I hired to be. So I'm not sure how much I should be focusing on this since the alleged goal of this exercise is to focus on Cucumber tests. So far, by necessity, that has been focused on the least.

That's my thought as I head into providing default codes for the bomb. And it is _not_ a happy thought.

At this point, I've found that while I like the basis of Cucumber, implementation wise it is very lacking and is cumbersome. (It's Cucumbersome!) The benefit of course is executable statements. However, you could do a layer like this in RSpec as well. One layer of RSpec would be unit focused and the other would be so-called acceptance focused. If the fear is losing Given-When-Then, you could wrap various types of libraries around RSpec to provide similar Gherkin-like nomenclature. The nice thing is you wouldn't be tied to Gherkin in that case.

### The Bomb Code as Object?

I'm at the point now where the check for valid code (in the `/trigger` route) has to be done in the post route for the index page as well. The problem is I can't call `trigger.valid?` during the post because a trigger instance has not been created. Does this suggest that a bomb code should be its own entity? On the one hand, an object for a code seems like overkill. On the other hand, various (admittedly contradictory) sources on Ruby coding practices suggest treating a value (like my codes) as objects. Or I suppose it could be the bomb itself. The whole idea was that the bomb was made of multiple components, one of which happens to be the trigger. But the trigger is mainly the mechanism for activating or deactivating the bomb. So now that I think on it, perhaps the codes should apply to a Bomb entity, which also starts getting more towards a modular entity overall.

Alternatively, I could just do jQuery validation. This, after all, is largely what I would want as a user. Why post something to the server when validation can be done in the interface itself without a server call?

### A Component-ized Bomb

I'm now at the point where I really, really need this bomb to be modular, the trigger in particular being just one part of it. This will impact the screens (to some extent) and thus the routes.

### Moderate Styling

At this point in the process, my client and I decided it would be worth it to spend some time on the interface aspects of the bomb provisioning application. Some of this styling was going to have an impact on the trigger mechanism, in particular. The idea was to limit the modality of the trigger mechanism by providing a keypad style interface.
