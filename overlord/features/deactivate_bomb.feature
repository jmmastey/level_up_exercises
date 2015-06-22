Feature: deactivate the bomb

  As a super villain
  I want to be able to deactivate my bomb
  in case my sinister plans change

  Scenario: Deactivate bomb
  Given that I am on the countdown bomb page
  When I submit an invalid deactivation code
  Then I should see a deactivation code error message
  When I submit a valid deactivation code
  Then the bomb should be deactivated


  Scenario: Three wrong deactivation attempts
  Given that I am on the countdown bomb page
  When I submit an invalid deactivation code three times
  Then the bomb should explode