Feature: Explode
  As a user
  I want the bomb to explode
  In order to ruin christmas, and not be invited to kens birthday party anymore.

  Scenario: Explode: Timer exipration
    Given I am logged in as a villain
    And the bomb is active
    When the bomb timer runs out
    Then I should see an explosion

  Scenario: Explode: Too many defusal attempts
    Given I am logged in as a villain
    And the bomb is active
    When the number of defusal attempts hits zero
    Then I should see an explosion

  Scenario: Explosion causes UI to freeze
    Given bomb has exploded
    Then I should not be able to press buttons
