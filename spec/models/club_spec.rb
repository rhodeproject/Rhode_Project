require 'spec_helper'

describe Club do
  before(:each) do
    @club = Club.new
  end

  it "should be valid with valid attributes" do
    @club.update_attributes(:name => "test club", :sub_domain => "test")
    @club.should be_valid
  end

  it "should not be valid without sub_domain" do
    pending "need to account for downcase of sub_domain before save"
  end

  it "should not be valid without name" do
    @club.update_attributes(:sub_domain => "test")
    @club.should_not be_valid
  end
end