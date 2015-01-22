Feature: Edit Contact Info
  In order to get weather updates
  As a registered user
  I want to be able to edit my contact information

  Background:
    Given I am logged in

  Scenario: Edit phone
    When I change my phone number and save
    Then I see my changed phone number

  Scenario: Edit name
    When I change my first and last name and save
    Then I see my changed first and last name

  Scenario: Edit all
    When I change my phone number
    And I change my first and last name
    And I save my contact info
    Then I see all of my updated contact info