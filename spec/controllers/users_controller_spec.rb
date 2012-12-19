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
    it "should render user_path" do
      response.should be_success
    end

  end

  describe "GET 'index'" do
    it "assigns users to @users" do
      User.stub(:scoped_by_club_id).and_return(@current_user)
      get :index
      assigns(:users).should eq(@current_user)
    end
  end

  describe "POST 'renew'" do
    it "renders the redirect to user template" do
      post :renew
      response.should redirect_to(users_path)
    end

    it "calls method pay membership fee" do
      token = "SOMETOKENTHATISPASSED"
      @current_user.stub(:pay_membership_fee).with(token, true).and_return(true)
      post :renew

    end
  end
end