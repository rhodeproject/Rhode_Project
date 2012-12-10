require 'spec_helper'

describe ProfilesController do

  describe "POST create" do
    before(:each) do
      @current_user = User.new(:name => "Foo Bar", :email => "foo@bar.com",
                               :password => "foobar",
                               :password_confirmation => "foobar")
      @current_user.admin = true
      @current_user.save!
    end

    it "creates a new profile" do
      post :create
      response.should redirect_to(current_user)
    end
    it "saves a new profile"
  end

end
