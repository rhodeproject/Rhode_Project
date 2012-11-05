require 'spec_helper'

describe Topic do

  before(:each) do
    @topic = Topic.new(:name => "Test Topic")
  end

  it "should be valid with valid attributes" do
    @topic.should be_valid
  end

  it "should not be valid without a name" do
    @topic.name = nil
    @topic.should_not be_valid
  end

end