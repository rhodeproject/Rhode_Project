require 'spec_helper'

describe Post do
  before(:each) do
    @post = Post.new(:content => "content")
  end

  it "should be valid with valid attributes" do
    @post.should be_valid
  end

  it "should be invalid with no content" do
    @post.content = nil
    @post.should_not be_valid
  end
end