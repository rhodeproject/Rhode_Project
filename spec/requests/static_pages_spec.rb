require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content Rhode Project" do
      pending
      visit '/home', {'HTTP_HOST' => 'www.rhodeproject.com'}
      page.should have_content('Rhode Project')
    end
  end
end
