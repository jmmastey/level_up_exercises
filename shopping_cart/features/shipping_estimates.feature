Feature: Get shipping estimates
  As a customer, before I check out
  They should get shipping estimates, when they enter address

  Scenario Outline:
    Given the customer is <login_status>
    And the cart has "item1"
    When customer enters <saved_address>
    Then shipping cost <calculate>

    Examples:
      | saved_address   | login_status     |    calculate              |
      | valid address   | logged in        |  should be calculated     |
      | invalid address | logged in        |  should not be calculated |
      | valid address   | not logged in    |  should be calculated     |
      | invalid address | not logged in    |  should not be calculated |

