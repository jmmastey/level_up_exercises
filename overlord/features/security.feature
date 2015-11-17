Feature: Application Security

  Scenario Outline: Access pages before booting
    When I go to <page>
    Then I should be redirected to the initialize page

    Examples:
      | page                   |
      | the home page          |
      | the bomb overview page |

  Scenario Outline: Access pages after booting
    Given that the bomb is booted
    When I go to <page>
    Then I should be redirected to the bomb overview page

    Examples:
      | page                 |
      | the home page        |
      | the initialize page  |

  Scenario Outline: Hide page not found before booting
    When I go to <page>
    Then I should be redirected to the initialize page

    Examples:
      | page                 |
      | a nonexistent page   |
      | the bomb boot action |

  Scenario Outline: Hide page not found after booting
    Given that the bomb is booted
    When I go to <page>
    Then I should be redirected to the bomb overview page

    Examples:
      | page                  |
      | a nonexistent page    |
      | the enter code action |

  Scenario: Access home page after booting
    Given that the bomb is booted
    When I go to the home page
    Then I should be redirected to the bomb overview page
