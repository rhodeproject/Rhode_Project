require 'spec_helper'

describe ForumsController do
  describe "Get 'edit'" do
    before do
      @forum = mock_model(Forum, :name => "Test")
    end
    it "renders the edit template" do
     get :edit, :id => @forum.id
     response.should render_template("edit")
   end
  end
end