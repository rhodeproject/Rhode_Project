require 'spec_helper'

describe Forum do
  before(:each) do
    @forum = Forum.new(:name => "Test Forum")
  end

  it "should be valid with valid attributes" do
    @forum.should be_valid
  end
end