#encoding: utf-8

Feature: Happy entering my address
  In order to get shipping estimates
  As an online shopper
  I should enter my address correctly

  @happy
  Scenario: Correct address entry
    Given I'm at the online store
    And I'm trying to get a shipping estimate
    And I have entered a correct address
    When I try to get a shipping estimate
    Then the page should list the proper rate for that address

  @sad
  Scenario: Address outside of shipping range
    Given I'm at the online store
    And I'm trying to get a shipping estimate
    And I have entered a correct address
    And the address is outside of the range for shipping
    When I try to get a shipping estimate
    Then it should fail
    And tell me I live in an area the cannot be shipped to

  @sad
  Scenario: Address invalid field(s)
    Given I'm at the online store
    And I'm trying to get a shipping estimate
    And I have entered an invalid street, city, state, country or zip
    Then it should fail
    And tell me which field(s) that i have entered are invalid

  @sad
  Scenario: Address field(s) are blank
    Given I'm at the online store
    And I'm trying to get a shipping estimate
    And I have entered nothing in 1 or more fields
    Then it should fail
    And tell me I need to finish the form

