@mainframe @bluezone
Feature: Running tests against a 3270 terminal emulator

  Scenario: Navigating a few screens
    When I navigate to the command screen
    And I type "logoff" on the screen
    Then I should be on the login screen

  Scenario: Taking a screenshot
    Given I navigate to the command screen
    And I take a screenshot called "example.png"
    Then I should have a file called "example.png"
    And I type "logoff" on the screen
    Then I should be on the login screen
