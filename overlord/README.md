## Super Villain's Detonation Device

You've been contacted by a super villain in search of help. He says he has a great idea, and needs only your genius to bring it to completion. Turns out the idea is going to be a bomb. I mean, literally. It's a bomb. Still, he's offering equity.

One tricky problem is that bombs are quite expensive to debug in prod. To avoid an embarrassing dud, you're going to develop and test the bomb in the relative safety of your own workshop (desk, really). Thankfully, you've got requirements, so mostly this is just an exercise of translating those requirements into working tests and then writing the software to control the bomb. 

But, this is the important part: you're going to write all the tests for the device before you write any of the app code. You cleverly realize that by writing the tests the way you'd like the code to work, you'll make your resulting code that much better. Well done, smartie.

### Requirements

1. Even coffee machines have webservers these days. The bomb interface should be a Sinatra app, and the tests should be written in Cucumber and Rspec. A simple Sinatra base has been provided.

2. The bomb interface should include a field to type in an activation / deactivation code and an indicator of the activation state of the bomb.

3. When the super villain first boots the bomb, it should not be activated.

4. The activation code is pretty simple:
  * The code should be configurable on boot. If no code is specified, 1234 seems pretty safe. Validate that only numeric inputs are allowed.
  * When the correct activation code is entered, the bomb should activate. Putting in the same activation code again should have no effect. From now on, the status indicator should let the user know that the bomb is active.

5. Next, the deactivation code.
  * This code should be configurable as well. A good default code would be 0000.
  * Once the bomb is active, putting in the correct deactivation code should cause the bomb to revert to inactivity, and indicate as such.
  * If a user puts in the wrong deactivation code three times, the bomb should explode. I'm not really sure what the interface would look like for this, since the bomb is exploded and all, but let's just indicate it somehow to be sure.
  * Once a bomb has exploded, none of the buttons work anymore. Obv.


### Super Optional Bonus Points
* The super villain doesn't have much aesthetic sense, but you do, so go ahead and make the interface look awesome and malevolent.
* Add a "confirm" button to the activation sequence. Once the activation code is entered, the user must confirm by pressing a big red button. Figure out what happens if you bail from the confirmation.
* Add a timer. All good bombs have timers.
* Add wires to snip to stop the bomb from detonating. This guy seems like he might not pay on time.
* No bonus points for developing an actual electronic detonator. Still, dude, sweet.