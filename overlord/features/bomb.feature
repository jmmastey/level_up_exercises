Feature: EVIL Bomb
  As a villian
  I want to have an EVIL bomb
  So that I can be a Supervillian

  Scenario: Deploy Bomb
    Given I visit the homepage
    When I enter the bomb activation code "1233"
    And I enter the bomb deactivation code "3872"
    And I click "DEPLOY"
    Then I expect the bomb status to be "ready for activation"

  Scenario: Activate Bomb
    Given I deployed a bomb with an activation code of "1233"
    When I enter a activation code "1233" on the page
    And I click "ACTIVATE"
    Then I expect the bomb status to be "activated"

  Scenario: Deactivate Bomb
    Given I deployed a bomb with a deactivation code of "3872"
    And I activated the bomb
    When I enter a deactivation code "3872" on the page
    And I click "DEACTIVATE"
    Then I expect the bomb status to be "ready for activation"

  Scenario: Enter Incorrect Deactivation Code 3 Times
    Given I deployed a bomb
    And I activated the bomb
    When I enter an incorrect deactivation code three times
    Then the bomb is exploded