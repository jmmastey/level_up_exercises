Feature: Search and viewing bills
  As a website visitor
  I want to find bills
  Because I want to learn about Congress

  Background:
    Given these bills exist:
      | official_title                                    | short_title                                 | summary_short                                                                 |
      | To amend the Federal Food, Drug, and Cosmetic Act | Safe and Accurate Food Labeling Act of 2015 | a plant or part of a plant that has been modified through recombinant DNA...  |

  @javascript
  Scenario: Search using a part of the official_title
    Given I am a new user
    When I search bills for "Federal Food"
    Then I should see 1 bill

  @javascript
  Scenario: Search using a part of the short_title
    Given I am a new user
    When I search bills for "Food Labeling"
    Then I should see 1 bill

  @javascript
  Scenario: Search using a part of the summary
    Given I am a new user
    When I search bills for "DNA recombinant"
    Then I should see 1 bill

  @javascript
  Scenario: Click on search result
    Given I am a new user
    When I search and click on a result for "recombinant DNA"
    Then I see the bill page for "Safe and Accurate Food Labeling Act of 2015"

  @javascript
  Scenario: No results found for search
    Given I am a new user
    When I search bills for "mystery alient act of 2025"
    Then I see "0 bills found for mystery alient act of 2025"
