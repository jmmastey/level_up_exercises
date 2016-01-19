## Exercise: Knows why we "Don't trust the developer"

1. Developers are a tricksey bunch. Name some reasons why you shouldn't just trust the person who wrote the code.
2. Name some mental pitfalls that you should watch out for when testing code.
3. So then, why shouldn't we be satisfied with testing our own code?

When reviewing the work or actions of anyone, especially developers, I always begin with the mindset from the Agile Retrospective prime directive:

>	Regardless of what we discover, we understand and truly believe that everyone did the best job they could, given what they knew at the time, their skills and abilities, the resources available, and the situation at hand.

That being said, we are humans, and making mistakes is what we do. And when you are a human creating software, you are pre-disposed to certain types of mistakes and biases, such as:

1. Confirmation-bias: I believe my code works, so I am only looking for information to reinforce that belief. Hence it is easier for someone who doesn't believe the code works to find problems with it.
2. Making assumptions about ambiguous requirements: I, many times unknowingly, make an incorrect assumption about a requirement and build that into my code.
3. Focusing on code that is changed: As a developer, I focus on the code I am changing/creating. Sometimes I fail to adequately explore how this code integrates into the application around it.
4. Four eyes are better than two: For whatever reason, it is easier for someone else to notice problems in my own code.
5. User Acceptance Bias: I want to get a story to done, which means passing the user Acceptance tests. But perhaps I have not been paying attention to other details such as code quality, failing states, technical debt, etc. It is easier for another party to point out these problems out when they are a bit more removed from the initial coding.

So in fact I do trust the person who wrote the code. I also trust that they have the same biases and failings as the rest of us. Some ways to mitigate these failings would be:

1. Create a checklist for all the things I should have an answer for when writing/editing code.
2. Ensure that my solution meets the how and why of what the end user needs.
3. Try to test the software wearing different hats. How would a user use this? How about an admin? It there something here that Ops would not like? If a problem occurred in this section, how would I debug it?
4. If I am not happy with the code I am writing, I should keep refactoring and working on it until I am happy. It is a smell that not feeling good about your code usually means it is crappy code.

And even if I do the above things, I will never totally remove all of my flaws and biases, and I should always have someone else review and test the code I have just written.  

## Exercise: Understands Red -> Green -> Refactor

1.  Explain how the red / green / refactor cycle works, and how it creates better code over time.

Red/Green/Refactor (RGF) allows us to iterate through our code as we are writing it. The idea is first you write the requirements into a test, and the tests are red. Then when you write enough code to be green, you have been focusing on making the tests pass, but perhaps not on making sure the code is clear, simple, concise, DRY, etc. So then you spend the refactoring step cleaning up the code you just wrote, knowing you have the safety net that the tests will break if your refactoring does not have the same behavior as the initially passing code.

It refactor step also allows you to change your point of view from making code that does what it should do, to making the code you have into good code. Code that is SOLID. Code that does not increase technical debt. Code that also perhaps makes you look again at the tests you have written.

Basically you are saying: you had a working 1st draft of code. Now lets take some time and make it better.
