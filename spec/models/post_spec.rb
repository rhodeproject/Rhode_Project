require 'spec_helper'

describe Post do
  before(:each) do
    @post = Post.new
  end

  it "should be valid with valid attributes" do
    @post.update_attributes(:content => "content")
    @post.should be_valid
  end

  it "should be invalid with no content" do
    @post.should_not be_valid
  end
end