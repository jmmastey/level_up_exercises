Feature: Browse Items
  In order to choose what I want to buy
  As a customer
  I want to be able to browse the items

  Scenario Outline: Browsing Scenarios
    Given I am <logged_in>
    And <number_of_items> items exist
    And I am on the <page> page
    And the "<item_name>" item exists
    When I click on <something>
    Then <something_happens>

  Examples: Look Around
    | logged_in     | number_of_items | page          | item_name | something                   | something_happens                |
    | not logged in | 5               | shopping cart | fishbowl  | the browse items button     | 5 items show on the page         |
    | logged in     | 5               | shopping cart | fishbowl  | the browse items button     | 5 items show on the page         |
    | not logged in | 5               | browse items  | fishbowl  | item "fishbowl" on the page | I go to the "fishbowl" item page |
    | logged in     | 5               | browse items  | fishbowl  | item "fishbowl" on the page | I go to the "fishbowl" item page |