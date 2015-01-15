Feature: use pagination to load data
  As professional runner
  I would like to filter funtion to reduce running event result

  @javascript
  Scenario Outline:
    Given I am on the events page
    When I try to filter events with "<run-type>","<start_date>" and "<end_date>"
    Then I should see the reponse successful


  @happy
    Examples:
        | run-type | start_date | end_date  |
        | 5K       | 2015-01-09 |           |
        | Running  | 2015-01-10 | 2015-01-17|
