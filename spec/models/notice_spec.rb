require 'spec_helper'

describe Notice do
  before(:each) do
    @notice = Notice.new
  end

  it "should be valid with content" do
    @notice.content = "some content"
    @notice.should be_valid
  end

  it "should not be valid with no content" do
    @notice.should_not be_valid
  end
end
