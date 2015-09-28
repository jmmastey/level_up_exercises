Feature: EVIL Bomb
  As a villian
  I want to have an EVIL bomb
  So that I can be a Supervillian

  Background:
    Given the villian is on the homepage
    When the villian enters the bomb activation code "1233"
    And the villian enters the bomb deactivation code "3872"

  Scenario: Deploy Bomb
    When the villian clicks "DEPLOY"
    Then the villian expects the bomb status to be "ready for activation"

  Scenario: Activate Bomb
    When the bomb has been deployed
    And the villian enters the bomb activation code "1233"
    And the villian clicks "ACTIVATE"
    Then the villian expects the bomb status to be "activated"

  Scenario: Deactivate Bomb
    When the bomb has been deployed
    And the bomb has been activated
    And the villian enters the bomb deactivation code "3872"
    And the villian clicks "DEACTIVATE"
    Then the villian expects the bomb status to be "ready for activation"

  Scenario: Enter Incorrect Deactivation Code 3 Times
    When the bomb has been deployed
    And the bomb has been activated
    And the hero enters an incorrect deactivation code three times
    Then the bomb should explode

  Scenario: Deploy Bomb with matching codes
    Given the villian is on the homepage
    When the villian enters the bomb activation code "1233"
    And the villian enters the bomb deactivation code "1233"
    And the villian clicks "DEPLOY"
    Then the page should say "Codes cannot match."