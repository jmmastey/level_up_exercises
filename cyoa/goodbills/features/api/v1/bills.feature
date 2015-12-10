Feature: GoodBills API
  In order to show bills and voting status
  as an API client
  I want to be able to request bills and vote on them

  Scenario: Get bills
    Given some bills
    When I ask for bills from the API
    Then I should receive them with voting information