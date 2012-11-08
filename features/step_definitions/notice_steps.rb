Given /^I am logged in as administrator$/ do
  @club = Club.create!(:name => "test", :sub_domain => "test")
  @admin = @club.users.build(:name => "admin", :email => "foo@bar.com", :password => "foobar", :password_confirmation => "foobar")
  @admin.update_attribute('admin', true)
  @admin.authenticate("foobar")
end

When /^I create a notice with content "([^"]*)"$/ do |content|
  @notice = Notice.new(:content => content)
end

Then /^I should see notice with content "([^"]*)"$/ do |content|
  #pending "Need to figure out how to get the club_id scope to work with test"
  visit notices_path
  response.should contain(content)
end