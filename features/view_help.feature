Feature: View Help
  So that users can get help
  when a user visits /help
  they can get help

Scenario:
  Given I am logged in
  When I visit the help link
  Then I should see help content
