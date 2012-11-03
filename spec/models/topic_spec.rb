require 'spec_helper'

describe Topic do

  before(:each) do
    @topic = Topic.new
  end

  it "should be valid with valid attributes" do
    @topic.update_attributes(:name => "Test Topic")
    @topic.should be_valid
  end

  it "should not be valid without a name" do
    @topic.should_not be_valid
  end

end