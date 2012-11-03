require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content Rhode Project" do
      visit '/'
      page.should have_content('Rhode Project')
    end
  end
end
