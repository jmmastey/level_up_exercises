Feature: GoodBills API
  In order to show bills and voting status
  as an API client
  I want to be able to request bills and vote on them

  Scenario: Get bills
    Given some bills
    When I ask for bills from the API
    Then I should receive them with voting information

  Scenario: Vote on a bill
    Given some bills
    When I vote that I like one
    And I ask for bills from the API
    Then my vote should be counted