require 'spec_helper'

describe "forums/edit.html.erb" do

  let(:forum1) do
    mock_model(Forum, :name => "Test Forum", :description => "this is a test forum")
  end

  it "renders a form"
end

