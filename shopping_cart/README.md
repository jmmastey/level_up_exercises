## Shopping Cart

You need some exercise in writing test plans. I've got the cure for what ails you. Write a test plan for a basic shopping cart. Make sure to include Happy Path, Sad Path and Bad Path in your tests.

It can be helpful to use something like the Cucumber syntax for this, but you don't need to write the entire implementation this time. You're welcome.

### Requirements

* The shopping cart behaves a lot like every other cart you've seen on the internet. We're not shooting for the stars on this one.
* I should be able to add, remove, and change quantities on items in my cart.
* I should be able to get back to item pages from the cart by clicking on individual cart item lines.
* I should be able to put in my address information to get shipping estimates.
* I should be able to add coupons, which are hopefully not expired.
* Pay attention to cases such as logging in (if I have items in my cart as an anonymous user, but also have cart items from a previous authenticated session), or adding another item of the same SKU as others in my cart.
* Don't worry about product pages or checkout.
