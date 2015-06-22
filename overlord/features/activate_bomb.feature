Feature: activate the bomb

  As a super villain
  I want to be able to activate my bomb
  so I can detonate it at will

  Scenario: Activate bomb
    Given that I am on the activate bomb page
    When I submit an invalid activation code
    Then I should see an activation code error message
    When I submit a valid activation code
    Then I should activate the bomb




