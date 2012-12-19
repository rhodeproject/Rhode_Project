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

  context "club subscription hooks" do

    before do
      @club = mock_model(Club, :name => "test club", :sub_domain => "test", :contact_email => "foo@bar.com", :subscription_id => "cus_123")
      Club.stub(:find_by_subscription_id).and_return(@club)

    end
    describe 'post to receiver that with invoice.payment_succeeded' do
      it "should send an email to club admin" do
        @club.should_receive(:send_subscription_update).with("invoice.payment_succeeded", "2500").and_return(true)
        post :subscription, {:type => "invoice.payment_succeeded", :id => "cus_123", :amount => "2500"}
        response.should be_success
      end
    end

    describe 'post to receiver with invoice.payment_failed' do
      it "should send an email to rhodeproject" do
        @club.should_receive(:send_subscription_update).with("invoice.payment_failed","2500").and_return(true)
        post :subscription, {:type => "invoice.payment_failed", :id => @club.subscription_id, :amount => "2500"}
        response.should be_success
      end
    end
  end

end
