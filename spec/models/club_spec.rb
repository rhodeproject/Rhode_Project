require 'spec_helper'

describe Club do
  before(:each) do
    @club = Club.new(:name => "test club", :sub_domain => "test")
    @club.update_attribute('subscription_id','cus_123')
  end

  it "should be valid with valid attributes" do
    @club.should be_valid
  end

  it "should not be valid without sub_domain" do
    pending "need to account for downcase of sub_domain before save"
  end

  it "should not be valid without name" do
    @club.name = nil
    @club.should_not be_valid
  end

  context "hooks response" do
    it "should send an email when subscription is updated" do
      @club.send_subscription_update("invoice.payment_failed","2500").should_not be_nil
    end
  end
end