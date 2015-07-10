
Feature: User can sort people's photos by attribute
  In order to get insight into Enova's people
  As the user
  I want to sort photos by facial attribute

  Scenario: See a photo of Michelle
    Given I am on the photos page
    Then I see Michelle in the photo description

  Scenario: See photos in default order
  	Given I am on the photos page
  	Then I see the photos sorted by happiness

