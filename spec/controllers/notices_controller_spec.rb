require 'spec_helper'

describe NoticesController do
  describe "POST create" do
    before(:each) do
      @current_user = User.new(:name => "Foo Bar", :email => "foo@bar.com",
                       :password => "foobar",
                       :password_confirmation => "foobar")
      @current_user.admin = true
      @current_user.save!
    end
    it "creates a new notice" do
      controller.stub!(:current_user).with(:admin).and_return(true)
      Notice.should_receive(:new).with(:content => "some content")
      post :create, :notice => { :content => "some content"}
    end
    it "saves a new notice"
  end
end
