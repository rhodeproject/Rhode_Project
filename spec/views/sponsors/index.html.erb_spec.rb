require 'spec_helper'

describe 'sponsors/index.html.erb' do

  before  do
    @sponsor = FactoryGirl.build(:sponsor)
    @sponsors = Array.new
    @sponsors << @sponsor
    view.stub_chain(:current_club, :name).and_return("test club")
    view.stub_chain(:sponsor, :image_path).and_return(@sponsor.image_name)
  end

  it 'renders a page with sponsors description' do
    render
    render.should contain(@sponsor.description)
  end

  it 'renders a form for new sponsor' do
    render
    render.should have_selector("form") do |form|
      form.should have_selector("input", :type => "submit")
    end
  end

  it "should render a form with text field for club name" do
    render
    render.should have_selector("form") do |form|
      form.should have_selector("input",
                  :type => "text",
                  :name => "sponsor[name]",
                  :value => "test sponsor")
    end
  end

  it "should render a form with text field for image name" do
    render
    render.should have_selector("form") do |form|
      form.should have_selector("input", :type => "text", :name => "sponsor[image_name]")
    end
  end

  it "should render a form with test field for sponsor url" do
    render
    render.should have_selector("form") do |form|
      form.should have_selector("input", :type => "text", :name => "sponsor[url]")
    end
  end

  it "should render a form with text field for sponsor description" do
    render
    render.should have_selector("form") do |form|
      form.should have_selector("textarea", :name => "sponsor[description]")
    end
  end

  it "should render a form with a text field for sponsor label" do
    render
    render.should have_selector("form") do |form|
      form.should have_selector("input", :type => "text", :name => "sponsor[label]")
    end
  end

  it "should render a form with a text field for sponsor priority" do
    render
    render.should have_selector("form") do |form|
      form.should have_selector("input", :type => "text", :name => "sponsor[priority]")
    end
  end

end