Feature: View Payments
  So a user can view membership payments
  As an administrator
  I should be able to click on user payment id
  and see details about the payment

Scenario: View a payment
  Given I visit the users page
  When I click on payment id on users list
  Then I should see payment details for that payment id

