require 'spec_helper'

describe ForumsController do
  #render_views
  before (:each) do
    @current_user = mock_model(User, :name => "test", :admin => true)
    @current_club = mock_model(Club, :name => "test club")
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:current_club).and_return(@current_club)
  end

  describe "GET 'edit'" do
    before do
      @forum = stub_model(Forum, :id => "1", :name => "test", :club_id => @current_club.id)
      Forum.stub(:find).and_return(@forum)
    end
    context "user is admin" do
      before do
        @current_user.stub(:admin?).and_return(true)
        get :edit, :id => 1
      end

      it "assigns forum to @forum" do
        assigns(:forum).should eq(@forum)
      end

    end

    context "user is not admin" do
      it "should redirect to forums_path" do
        @current_user.stub(:admin?).and_return(false)
        get :edit, :id => 1
        response.should redirect_to(forums_path)
      end

      it "displays flash message" do
        flash.should_not be_nil
      end

    end
  end

  describe "GET 'show'" do
    before do
      @forum = stub_model(Forum, :id => "1",:name => "test", :club_id => @current_club.id)
      Forum.stub(:find).and_return(@forum)
    end

    it "assigns forum to @forum" do
      get :show, :id => 1
      assigns(:forum).should eq(@forum)
    end

    it "assigns forum topics to @topics" do
      topics = mock_model(Topic, :name => "test topic", :content => "some stuff")
      Forum.stub_chain(:topics, :paginate, :order, :includes).and_return(topics)
      get :show, :id => 1
      assigns(:topics).should_not be_nil
    end

    it "renders the show template" do
      pending "not sure why render is not working"
      get :show, :id => 1
      response.should render_template('show')
    end
  end

  describe "GET 'index'" do
    before do
      @forums = stub_model(Forum, :name => "test forum", :club_id => @current_club.id, :admin => true)
    end
    context "when signed in as admin" do
      it "assigns all club forums to @forums" do
        @current_user.stub!(:admin?).and_return(true)
        Forum.stub_chain(:scoped_by_club_id, :order) {[@forums]}
        get :index
        assigns(:forums).should eq([@forums])
      end
    end

    context "when not signed in as admin" do
      it "assigns all non admin club forums to @forums" do
        pending "need to determine how to assign admin to mock model"
        @current_user.stub!(:admin?).and_return(false)
        Forum.stub_chain(:scoped_by_club_id, :where, :order) {[@forums]}
        get :index
        assigns(:forums).should be_nil
      end
    end
  end
end