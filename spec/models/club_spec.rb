require 'spec_helper'

describe Club do
  before(:each) do
    @club = Club.new(:name => "test club", :sub_domain => "test")
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
end