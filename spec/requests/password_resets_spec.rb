require 'spec_helper'

describe "PasswordResets" do
    it "email user when requesting password reset"
    #user = Factory(:user)
    visit signin_path
    click_link "password"
    fill_in "Email", :with => 'foo@bar.com'
    click_button "reset"

end

