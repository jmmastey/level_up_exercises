Feature: Activation
  In order to activate the bomb
  As an evil overlord
  I should be able to input my specified activation code

  Scenario: Attempt to jump directly to the activation page
    Given I am on the activation page
    Then I should be on the home page

  Scenario: Correctly displays bomb status
    Given I am on the homepage
    And I press "Submit"
    Then I should see "Bomb Status: Inactive"

  Scenario: Accepts the default activation code
    Given I specified my "activation" code as ""
    And I fill in "activation" with "1234"
    And I press "Activate"
    Then I should be on the deactivation page

  Scenario: Accepts a specified activation code
    Given I specified my "activation" code as "1111"
    And I fill in "activation" with "1111"
    And I press "Activate"
    Then I should be on the deactivation page

  Scenario: Double activation should have no effect
    Given I am on the homepage
    And I press "Submit"
    And I fill in "activation" with "1234"
    And I press "Activate"
    And I go to the activation page
    And I fill in "activation" with "1234"
    And I press "Activate"
    Then I should be on the deactivation page

  Scenario: Incorrect activation code
    Given I specified my "activation" code as ""
    And I fill in "activation" with "1111"
    And I press "Activate"
    Then I should be on the activation page

   Scenario: Incorrect non-numeric activation code (shouldn't accept for security)
     Given I am on the homepage
     And I press "Submit"
     And I fill in "activation" with "Hello"
     And I press "Activate"
     Then I should be on the activation page