## Thoughts on the 5 second code review

When building world class applications, we wish our code to have the following properties:
1. Readable
2. Extensible
3. Performant
4. Secure

The five second code review test is an indicator of how readable the code is. The basic assumption is that an experienced developer should not need more than 5 seconds to understand the basic functioning of a method in the code base. The reason being that if more than 5 seconds is needed, it is not clear what exactly that method is trying to accomplish, and the code is not very readable.

So a good rule of thumb is to call over a teammate, and see if they can understand some of your more complex methods in short order. If they can't, then perhaps some refactoring is in order.
