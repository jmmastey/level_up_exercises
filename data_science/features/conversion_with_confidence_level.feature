Feature: Conversion with confidence level functionality
  Given a sample then the conversion rate is calculated correctly
  for each group with required confidence level

  Scenario: Check that conversion rates are calculated correctly
    Given a sample with appropriate data
    And a confidence level is assigned                          
    When Results are calculated
    Then it returns a range of values                       
    And it returns a valid error rate 
