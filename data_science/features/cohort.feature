Feature: Cohort parsing
  For raw data, when it is parsed, then cohorts are
  appropriately returned

  Scenario: Check that cohort is parsed properly
    Given a sample with appropriate data                          
    When raw data is parsed                  
    Then it returns 2 cohorts
 
#  Scenario: Check that error for incorrect data is returned
#    Given a sample with incorrect data
#    When conversion rate formula is applied
#    Then it raises an error "Sample size smaller than conversions"                         
