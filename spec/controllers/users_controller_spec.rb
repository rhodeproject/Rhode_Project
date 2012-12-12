require 'spec_helper'

describe UsersController do
  before(:each) do
    @current_user = mock_model(User, :name => "test", :admin => true)
    @current_club = mock_model(Club, :name => "test club")
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:current_club).and_return(@current_club)
  end
  describe "GET 'show'" do
    it "should assign user to @user" do
      @user = stub_model(User, :name => "test", :email =>"foo@bar.com", :club_id => @current_club.id )
      User.stub(:find).and_return(@user)
      get :show, :id => @user.id
      assigns(:user).should eq(@user)
    end
    it "should render user_path"
  end

  describe "GET 'index'" do
    it "assigns users to @users"
  end

end