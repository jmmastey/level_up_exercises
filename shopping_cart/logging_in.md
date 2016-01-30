###Feature: Guest carts and logging in
* In order to have as few barriers to purchasing merchandise as possible
* I need to be able to save my cart and come back to it later

####Scenario: Logging in with a saved item (Happy)
* Given that I am not logged in
* And I am viewing my empty cart
* And I added an item to my cart previously when I was logged in
* When I log in with valid credentials
* Then I should see the item in my cart from my last session

####Scenario: Logging in with a saved in-stock item and a new item (Happy)
* Given that I am not logged in
* And I have added an item to my cart as a guest user
* And I added an item to my cart previously when I was logged in
* And that item from before is still is stock
* When I log in with valid credentials
* Then I should see both items in my cart

####Scenario: Attempting to log in without password (Sad)
* Given that I am not logged in
* And I have added an item to my cart as a guest user
* And I added an item to my cart previously when I was logged in
* When I attempt to log in without entering my password
* Then I should see an error message that prompts me to enter a password
* Then I should see no change in my cart

####Scenario: Attempting to log in without user name (Sad)
* Given that I am not logged in
* And I have added an item to my cart as a guest user
* And I added an item to my cart previously when I was logged in
* When I attempt to log in without entering my user name
* Then I should see an error message that prompts me to enter a user name
* Then I should see no change in my cart

####Scenario: Logging in with a saved out-of-stock item and a new item (Bad)
* Given that I am not logged in
* And I have added an item to my cart as a guest user
* And I added an item to my cart previously when I was logged in
* And that item from before is no longer in stock
* When I log in with valid credentials
* Then I should see only the item I added as a guest user in my cart

####Scenario: Attempting to log in with invalid credentials (Bad)
* Given that I am not logged in
* And I have added an item to my cart as a guest user
* And I added an item to my cart previously when I was logged in
* When I attempt to log in with invalid credentials
* Then I should see an error message prompting me to enter valid credentials
* Then I should see no change in my cart
