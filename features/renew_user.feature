Feature: Renew User
  So that a user can renew her account
  when the she visits the renew link
  she can sign up for another year

Scenario: Renew Account
  Given I have an account
  When I visit the renew link
  Then I should be able to sign up for another year
