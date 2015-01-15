Feature: use pagination to load data
  @javascript 
  Scenario Outline:
    Given I am on the events page
    When I click page "<page_num>"
    Then I should page "<page_num>" is marked

  @happy
    Examples:
        | page_num | 
        | page_1   |
        | next     |
  @sad
    Examples:
        | page_num |
        | previous |
