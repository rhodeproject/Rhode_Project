require 'spec_helper'

describe NoticesController do
  describe "POST create" do
    before(:each) do
      @current_club = create(:club)#mock_model(Club, :name => "test club")
      @notice = create(:notice)
      @current_user = create(:user)#mock_model(Club, :club_id => 1, :name => "test club")
      controller.stub!(:current_user).and_return(@current_user)
      controller.stub!(:current_club).and_return(@current_club)
      @current_user.stub(:admin).and_return(true)
      @current_user.stub(:notices).and_return(@notices)

    end
    it "creates a assigns notice to @notice" do
      post :create, :notice => { :content => "some content"}
      assigns(:notice).should_not be_nil
    end

    it "saves a new notice with flash message" do
      @notice.stub(:save).and_return(true)
      flash.should_not be_nil

    end
  end
end
