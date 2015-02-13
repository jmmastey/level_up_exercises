Feature: Bomb Activation

  Scenario: Activating a bomb with a valid code
    Given I am on the home page
    Then I should see the image "overlord" within "container"
      And I should see "Valentine's Bomb" within "intro-text"
      And I should see "Desperate - Single - Ready to Mingle" within "intro-text"
    When hovering on the Overlord image
      And clicking the image
    Then I am on bomb activation page
      And should see the field "boot_code" within "row"
      And should see the button "submit" within "row"
    When I will enter my boot code:
      | code | 6969 |
      And click the submit button
    Then I should be on bomb creation page

  Scenario: Activating a bomb with an invalid code
    Given I am on the home page
    Then I should see the image "overlord" within "container"
      And I should see "Valentine's Bomb" within "intro-text"
      And I should see "Desperate - Single - Ready to Mingle" within "intro-text"
    When hovering on the Overlord image
      And clicking the image
    Then I am on bomb activation page
      And should see the field "boot_code" within "row"
      And should see the button "submit" within "row"
      When I will enter my boot code:
      | code | 1000 |
      And click the submit button
    Then I should not be on bomb creation page
      And I am on bomb activation page
