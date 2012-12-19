require 'spec_helper'

describe ProfilesController do

  describe "POST create" do
    before(:each) do
      @current_user = create(:user)
      controller.stub!(:current_user).and_return(@current_user)
      post :create, :profile => {:bio => "stuff", :blog => "http://www.foobar.com"}
    end

    it "creates a new profile" do
      assigns(:profile).should_not be_nil
    end

    it "saves a new profile with flash message"
  end

end
