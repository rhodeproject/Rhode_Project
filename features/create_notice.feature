Feature: Create notice
  So that members can see club notices
  As a site administrator
  I want to create a notice that will display on members home page

  Scenario: Create a notice
    Given I am logged in as administrator
    When I create a notice with content "stuff"
    Then I should see notice with content "stuff"



