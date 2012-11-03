require 'spec_helper'

describe Token do
  it "should be valid with valid no attributes" do
    token = Token.new
    token.should be_valid
  end
end
