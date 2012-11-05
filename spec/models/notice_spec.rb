require 'spec_helper'

describe Notice do
  before(:each) do
    @notice = Notice.new(:content => "some content")
  end

  it "should be valid with content" do
    @notice.should be_valid
  end

  it "should not be valid with no content" do
    @notice.content = nil
    @notice.should_not be_valid
  end
end
