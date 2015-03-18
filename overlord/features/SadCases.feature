Feature: Evil mastermind wants to config a bomb, but enters bad data.
Whomp whomp

Scenario: Mastermind Lands on the main page and enters nothing in the Activation code
  Given I am on the home page
  When I enter no code in the 'activation' box
  Then I see the alert box and I accept the alert
  When I enter '1236' in the 'activation' box
  Then I have '1236' in the 'Activation' box

Scenario: Mastermind Lands on the main page and enters nothing in the Deactivation code
  Given I am on the home page
  When I enter no code in the 'deactivation' box
  Then I see the alert box and I accept the alert
  When I enter '1236' in the 'deactivation' box
  Then I have '1236' in the 'Deactivation' box

Scenario: Mastermind enters the default codes for the bomb, but enters nothing in the activation box.
  Given I am on the home page
  When I use the default codes
  Then I land on the Activate page
  When I enter no code in the 'activation' box
  Then I see the alert box and I accept the alert
  When I enter '1234' to activate the bomb
  Then the bomb status is 'active'

Scenario: Mastermind enters the cusotm codes for the bomb, but enters nothing in the activation box.
  Given I am on the home page
  When I enter '6789' and '9876' into the bomb
  Then I land on the Activate page
  When I enter no code in the 'activation' box
  Then I see the alert box and I accept the alert
  When I enter '6789' to activate the bomb
  Then the bomb status is 'active'
