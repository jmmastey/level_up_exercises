Feature: Interacting with legislators data
  As a website visitor
  I want to search and view legislator data
  Because I want to learn about the legislators

  Background:
    Given the following legislators exist:
      | first_name    | last_name    | party | title | state   | district  |
      | Bob           | Jones        | D     | Rep   | IL      | 7         |
      | Alice         | Smith        | R     | Sen   | NY      | 12        |
    And the following congressional districts exist:
      | congressional_district_id | state | zipcode   |
      | 7                         | IL    | 60606     |

  @javascript
  Scenario: Search legislators by name
    Given I visit "/"
    When I search legislators for "Bob"
    Then I see 1 legislators

  @javascript
  Scenario: Search legislators by title
    Given I visit "/"
    When I search legislators for "Representative"
    Then I see 1 legislators

  @javascript
  Scenario: Search legislators by party
    Given I visit "/"
    When I search legislators for "Republican"
    Then I see 1 legislators

  @javascript
  Scenario: Search legislators by state
    Given I visit "/"
    When I search legislators for "Illinois"
    Then I see 1 legislators

  @javascript
  Scenario: Search legislators by zipcode
    Given I visit "/"
    When I search legislators for "60606"
    Then I see 1 legislators

  @javascript
  Scenario: View a particular legislator
    Given I visit "/"
    And I search legislators for "Bob"
    When I click on "Bob"
    Then I see the legislator page for "Bob"
