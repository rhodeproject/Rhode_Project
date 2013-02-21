require 'spec_helper'

describe UsersController do
  before(:each) do
    @current_user = mock_model(User, :name => "test", :admin => true)
    @current_club = mock_model(Club, :name => "test club")
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:current_club).and_return(@current_club)

  end

  describe "GET 'usercheck'" do
    it "should return true if the email and club_id is unique"
    it "should return false if the email and club_id are not uniqueu"
  end

  describe "GET 'show'" do
    it "should assign user to @user" do
      @user = stub_model(User, :name => "test", :email =>"foo@bar.com", :club_id => @current_club.id )
      User.stub(:find).and_return(@user)
      get :show, :id => @user.id
      assigns(:user).should eq(@user)
    end
    it "should render user_path" do
      response.should be_success
    end

  end

  describe "GET 'index'" do
    it "assigns users to @users" do
      pending "chain stubs..."
      User.stub(:scoped_by_club_id).and_return(@current_user)
      @current_user.stub(:admin?).and_return(false)
      User.stub(:scoped_by_club_id).stub(:active_users).stub(:by_name).and_return(@current_user)
      get :index
      assigns(:users).should eq(@current_user)
    end
  end
end