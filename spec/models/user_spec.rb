require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build(:user)
    @user.update_attribute('admin',false)
  end

  context "referral count" do
    it "should increment when a new user is referred" do
      @user.add_referral
      @user.referral_count.should eq(1)
    end
  end

  context "valid tests" do
    it "should be valid with valid attributes" do
      @user.should be_valid
    end

    it "should be valid with same email and different club_id" do
      @user2 = FactoryGirl.build(:user)
      @user2.club_id = 2
      @user2.should be_valid
    end

  end

  context "invalid attributes" do
    it "should be invalid with no name" do
      @user.name = nil
      @user.should_not be_valid
    end

    it "should be invalid with same email and club_id" do
      #pending 'need to figure out Factory with same email'
      @another_user = FactoryGirl.build(:user)
      @another_user.email = @user.email
      @another_user.should_not be_valid
    end

    it "should be invalid with no email" do
      @user.email = nil
      @user.should_not be_valid
    end

    it "should be invalid with no password" do
      @user.password = nil
      @user.should_not be_valid
    end

    it "should be invalid with no password_confirmaiton" do
      @user.password_confirmation = nil
      @user.should_not be_valid
    end

    it "should be invalid if password_confirmation does not match password" do
      @user.password_confirmation = @bad_password_confirmation
      @user.should_not be_valid
    end

    it "should be invalid with invalid email address" do
      @user.email = "wwrwerwerwerwerwer"
      @user.should_not be_valid
    end

    it "should be invalid with short password" do
      @user.password = "12345"
      @user.should_not be_valid
    end

  end

  context "check for active users" do
    it "should be inactive" do
      @user.active?.should be_false
    end

    it "should be active once set as active" do
      @user.activate_user
      @user.active.should be_true
    end

  end

  context "check for admin" do
    it "should not be admin" do
      @user.admin?.should be_false
    end

    it "should be admin if set to admin" do
      @user.make_admin
      @user.admin?.should be_true
    end
  end
end