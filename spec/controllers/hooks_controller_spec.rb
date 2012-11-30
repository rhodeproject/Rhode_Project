require 'spec_helper'

describe HooksController do

  before(:each) do
    @user = mock_model(User, :name => "Test User", :email => "foo@bar.com", :stripe_id => "12345", :active => false)
    User.stub(:find_by_stripe_id).and_return(@user)
  end

  describe 'post should be successful' do
    it 'should return http ok' do
      post :receiver
      response.should be_success
    end
  end

  describe 'post to receiver on successful charge' do
    it "user should be active" do
      @user.should_receive(:update_attribute).with('active', true)
      post :receiver, {:type => "charge.succeeded"},{:id => "12345"}
    end
  end

  describe 'post to receiver with failed message' do
    it "user should be inactive" do
      @user.should_receive(:update_attribute).with('active', false)
      post :receiver, {:type => "charge.failed"},{:id => "12345"}
    end
  end
end
