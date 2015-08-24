Feature: Destroying the world
  In order to verify that the bomb can properly be detonated
  As a supervillian
  I should be able to detonate the bomb and destroy the world

  Background: Activate bomb
    Given I visit the home page
    And I boot up the bomb
    And I activate the bomb with code "1234"

  Scenario: Destroying the world by incompetence
    When I fail at deactivating the bomb
    Then the world will be destroyed

  # Scenario: Destroying the world by laziness
  #   Given I visit the home page
  #   When I boot up the bomb
  #   And I activate the bomb with code 1234
  #   And I wait for 30 seconds
  #   Then the world will be destroyed
