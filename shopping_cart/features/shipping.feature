Feature: Calculates shipping
  As a shopper
  In order to know my shipping charges beforehand
  I want to calculate the shipping charges

  Background:
    Given the site ships to lower 48
      And user is in the cart page

  @happy
  Scenario Outline: Calculate shipping
    When user request calculation for a zip in <state>
    Then I see correct shipping charges for <state>

    Examples:
    | state    |
    | Alabama  |
    | Colorado |

  @sad
  Scenario Outline: Calculate shipping for a Zip site does not ship
    When user request calculation for a zip in <state>
    Then I see we do not ship to <state> error

    Examples:
    | state    |
    | Alaska   |
    | Hawaii   |

  @bad
  Scenario: Zip does not confirm to the pattern
    When user request calculation for a zip "; drop users"
    Then I see invalid zip format error
