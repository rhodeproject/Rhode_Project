require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new
    @name = "Test User"
    @email = "foo@bar.com"
    @password = "foobar"
    @bad_password_confirmation = "barfoo"
    #club_id??
  end

  it "should be valid with valid attributes" do
    @user.update_attributes(:name => @name, :email => @email,
                            :password => @password,
                            :password_confirmation => @password)
    @user.should be_valid
  end

  it "should be invalid with no name" do
    @user.update_attributes(:email => @email,
                            :password => @password,
                            :password_confirmation => @password)
    @user.should_not be_valid
  end

  it "should be invalid with invalid email address" do
    bad_email = "wwrwerwerwerwerwer"
    @user.update_attributes(:name => @name, :email => bad_email,
                            :password => @password,
                            :password_confirmation => @password)
    @user.should_not be_valid
  end

  it "should be invalid with short password" do
    short_pass= "12345"
    @user.update_attributes(:name => @name, :email => @email,
                            :password => short_pass,
                            :password_confirmation => short_pass)
    @user.should_not be_valid
  end

  it "should be invalid with no email" do
    @user.update_attributes(:name => @name, :email => "",
                            :password => @password,
                            :password_confirmation => @password)
    @user.should_not be_valid
  end

  it "should be invalid with no password" do
    @user.update_attributes(:name => @name, :email => @email,
                            :password => "",
                            :password_confirmation => @passwordt)
    @user.should_not be_valid
  end

  it "should be invalid with no password_confirmaiton" do
    @user.update_attributes(:name => @name, :email => @email,
                            :password => @password,
                            :password_confirmation => "")
    @user.should_not be_valid
  end

  it "should be invalid if password_confirmation does not match password" do
    @user.update_attributes(:name => @name, :email => @email,
                            :password => @password,
                            :password_confirmation => @bad_password_confirmation)
    @user.should_not be_valid
  end

  it "should be inactive" do
    @user.active?.should be_false
  end

  it "should be active once set as active" do #not sure if this really makes sense
    #@user.activate_user #I think this is an issue because activate_user relies on created_at date
    @user.active = true
    @user.active.should be_true
  end

  it "should not be admin" do
    @user.admin?.should be_false
  end

  it "should be admin if set to admin" do
    @user.make_admin
    @user.admin?.should be_true
  end

end