Given /^I have an account$/ do
  @user = mock_model(User, :name => "Test", :email => "foo@bar.com")
end

When /^I visit the renew link$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should be able to sign up for another year$/ do
  pending # express the regexp above with the code you wish you had
end