Feature: Conversion functionality
  Given a sample then the conversion rate is calculated correctly
  for each group

  Scenario: Check that conversion rates are calculated correctly
    Given a sample with appropriate data                          
    When conversion rate formula is applied                     
    Then it returns a valid result
 
#  Scenario: Check that error for incorrect data is returned
#    Given a sample with incorrect data
#    When conversion rate formula is applied
#    Then it raises an error "Sample size smaller than conversions"                         
