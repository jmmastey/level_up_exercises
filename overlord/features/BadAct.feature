Feature: Evil mastermind configs a bomb, but enters bad data in the activation field and bomb is not activated.
Whomp whomp

Scenario: Mastermind Lands on the main page and enters default values
and puts the wrong activation code in
  Given I am on the home page
  When I use the default codes
  Then I land on the Activate page
  When I enter '1235' to activate the bomb
  Then the bomb status is 'inactive'
  When I enter '1234' to activate the bomb
  Then the bomb status is 'active'

Scenario: Mastermind Lands on the main page and enters values for the codes and puts the wrong activation code in
  Given I am on the home page
  When I enter '6789' and '9876' into the bomb
  Then I land on the Activate page
  When I enter '1235' to activate the bomb
  Then the bomb status is 'inactive'
  When I enter '9876' to activate the bomb
  Then the bomb status is 'active'






