#encoding: utf-8

Feature: Happy entering my address
  In order to get shipping estimates
  As an online shopper
  I should enter my address correctly
  And have items in my cart

  Scenario: Correct address entry
    Given I'm at the online store
    And I'm trying to get a shipping estimate
    And I have entered a correct address
    When I try to get a shipping estimate
    Then it should list the proper rate for that address

