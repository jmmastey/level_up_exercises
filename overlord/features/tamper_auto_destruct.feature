Feature: Auto-Destruct on Attempt to Tamper
  As a would-be tamperer who means to disrupt the bomb attacke
  I want my attempt to tamper to trigger the explosion
  So my plan to save the day will fail

Scenario: Enter incorrect disarming codes three times explodes bomb
  Given the bomb is armed
  When I attempt to disarm bomb with incorrect disarming code 3 times
  Then I see the bomb explode
