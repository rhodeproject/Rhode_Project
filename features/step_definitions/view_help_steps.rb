Given /^I am logged in$/ do
  @club = Club.create!(:name => "test", :sub_domain => "test")
  @user = @club.users.build(:name => "admin", :email => "foo@bar.com", :password => "foobar", :password_confirmation => "foobar")
  sign_in @user
end

When /^I visit the help link$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see help content$/ do
  pending # express the regexp above with the code you wish you had
end

def sign_in(user)
  cookies.permanent[:remember_token] = user.remember_token
end
