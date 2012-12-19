require 'spec_helper'

describe SessionsController do
  before do
    @club = create(:club)
    @user = create(:user)
  end
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should create new session" do
      pending
      controller.stub!(:check_active).and_return(true)
      controller.stub(:find_club).with(@club.sub_domain).and_return(@club)
      User.stub(:find_by_email_and_club_id).with(@user.email,@club.id).and_return(@user)
      post :create , :session => {:email =>"foo@bar.com", :club_id => @club.id}
    end
    it "should redirect to user_path"
  end


end