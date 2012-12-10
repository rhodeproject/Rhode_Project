require 'spec_helper'

describe SessionsController do
  before do
    @club = mock_model(Club, :name => "Test Club", :active => true, :email => "foo@bar.com")
    @user = mock_model(User,
                       :name => "Test User",
                       :club_id => @club.id)
  end
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should create new session" do
      controller.stub!(:check_active).and_return(true)
      User.should_receive(:find_by_email_and_club_id).and_return(@user)
      post :create , :user => {:email =>@user.email, :club_id => @club.id}
    end
    it "should redirect to user_path"
  end


end