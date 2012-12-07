require 'spec_helper'

describe "clubs/edit.html.erb" do

  let (:club) do
    mock_model(Club, :name => "test",
               :sub_domain => "test-domain",
               :terms_and_conditions => "some legal stuff",
               :contact_email => "foo@bar.com",
               :fee => "45",
               :heading1 => "club heading 1",
               :heading2 => "club heading 2",
               :heading3 => "club heading 3",
               :message1 => "club message 1",
               :message2 => "club message 2",
               :message3 => "club message 3",
               :about => "about us",
               :oath_token => "oathtoken",
               :oath_token_secret => "oathtokensecret",
               :stripe_publishable_key => "stripepublishablekey",
               :stripe_api_key => "stripe_api_key")
  end
  before do
    assign(:club, club)
  end
  it "renders a form to edit a club" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input", :type => "submit")
    end
  end

  it "renders a text field to edit the club url" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                  :type => "text",
                  :name => "club[sub_domain]",
                  :value => "test-domain"
                  )

    end
  end

  it "renders a text field with contact email" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                  :type => "text",
                  :name => "club[contact_email]",
                  :value => "foo@bar.com")
    end
  end

  it "renders a text field with club fee" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                  :type => "text",
                  :name => "club[fee]",
                  :value => "45")
    end
  end

  it "renders a text field with heading 1" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                  :type => "text",
                  :name => "club[heading1]",
                  :value => "club heading 1")
    end
  end

  it "renders a text field with heading 2" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                                :type => "text",
                                :name => "club[heading2]",
                                :value => "club heading 2")
    end
  end

  it "renders a text field with heading 3" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                                :type => "text",
                                :name => "club[heading3]",
                                :value => "club heading 3")
    end
  end

  it "renders a text area with message 1" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("textarea",
                                :name => "club[message1]",
                                :content => "club message 1")
    end
  end

  it "renders a text area with message 2" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("textarea",
                                :name => "club[message2]",
                                :content => "club message 2")
    end
  end

  it "renders a text area with message 3" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("textarea",
                                :name => "club[message3]",
                                :content => "club message 3")
    end
  end

  it "renders a text area about us" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("textarea",
                  :name => "club[about]",
                  :content => "about us")
    end
  end

  it "renders a text area terms and conditions" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("textarea",
                  :name => "club[terms_and_conditions]",
                  :content => "some legal stuff")
    end
  end

  it "redners a text field with oath token" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                                :type => "text",
                                :name => "club[oath_token]",
                                :value => "oathtoken")
    end
  end

  it "redners a text field with oath token secret" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                                :type => "text",
                                :name => "club[oath_token_secret]",
                                :value => "oathtokensecret")
    end
  end

  it "renders a text field with stripe_publishable_key" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                  :type => "text",
                  :name => "club[stripe_publishable_key]",
                  :value => "stripepublishablekey")
    end
  end

  it "renders a field with stripe_api_key" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                                :type => "text",
                                :name =>"club[stripe_api_key]",
                                :value => "stripe_api_key")
    end
  end
end