Feature: Bomb Activation

  Scenario: Activating a bomb with a valid code
    Given I am in the home page
    Then I should see an overlord image
      And should have a name Valentine's Bomb
    When hovering on the Overlord image
      And clicking the image
    Then I should be redirected to bomb activation page
      And should see a field for entering my code
      And should see a submit button
    When I will enter my boot code:
      | code | 6969 |
      And click the submit button
    Then be redirected to the bomb creation page

  Scenario: Activating a bomb with an invalid code
    Given I am in the home page
    Then I should see an overlord image
      And should have a name Valentine's Bomb
    When hovering on the Overlord image
      And clicking the image
    Then I should be redirected to bomb activation page
      And should see a field for entering my code
      And should see a submit button
    When I will enter my boot code:
      | code | 1000 |
      And click the submit button
    Then not be redirected to the bomb creation page
      And remain on the boot device page
