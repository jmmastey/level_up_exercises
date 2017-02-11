Feature: The bomb will go bang
  In order blow things up
  As a bomber
  I want the bomb to actually explode

  Scenario: I get the deactivation code wrong three times
    Given I visit the root page
    When I submit the the wrong de activation code three times
    Then the bomb will explode
