Feature: Customer logs in before checkout

  Background:
    Given customer is not logged in
    And customer has email "johndoe@example.com" and password "0000"
    And the cart has following:
    | item_1 |
    | item_2 |

  Scenario Outline: Customer logs in with valid credentials
    Given I log in with email <right_email> and password <right_password>
    Then I see an successful login message
    When I visit the cart
    Then I should see following in the cart:
    | item_1 |
    | item_2 |

    Examples:
      | right_email           | right_password  |
      | "johndoe@example.com" | "0000"          |

  Scenario Outline: Customer logs in with invalid credentials
    Given I log in with email <wrong_email> and password <right_password>
    Then I see an unsuccessful login message

    Examples:
      | wrong_email           | right_password  |
      | "foobar@example.com"  | "0000"          |

  Scenario Outline: Customer logs in with invalid credentials
    Given I log in with email <right_email> and password <wrong_password>
    Then I see an unsuccessful login message

    Examples:
      | wrong_email           | right_password  |
      | "johndoe@example.com" | "1234"          |
