Feature: Existing User
  As an existing user
  I want to be able to interact with my personal account

  Background:
    Given I have an account
    And I securely visit the login page

  Scenario Outline: Log into account
    When I enter in my <username> and <password>
    And click login
    Then I expect to be logged in
    And taken to my account page

  Scenario: Add default shipping address
    When I login
    And I go to the account settings page
    And click on shipping information
    And I enter in my shipping location
    And click save
    Then I expect to have a shipping location in my account

  Scenario Outline: Wrong password when logging in
    When I enter in my <username>
    And I enter in the wrong <password>
    And click login
    Then I expect to have an invalid credentials error

  Scenario Outline: Username does not exist when logging in
    When I enter in a nonexistant <username>
    And I enter in my <password>
    And click login
    Then I expect to have an invalid credentials error

  Scenario: Add invalid shipping address
    When I login
    And I go to the account settings page
    And click on the shipping information
    And enter in an invalid address
    And click save
    Then I expect to have an invalid address error