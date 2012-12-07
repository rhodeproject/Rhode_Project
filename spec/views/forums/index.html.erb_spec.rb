require 'spec_helper'


describe "forums/index.html.erb" do


  let(:forum1) do
    mock_model(Forum, :name => "Test Forum", :description => "this is a test forum")
  end

  let(:forum2) do
    mock_model(Forum, :name => "Test Forum2", :description => "this is a test forum 2")
  end

  let(:topic1) do
    mock_model(Topic, :name => "test topic 1")
  end

  let(:topic2) do
    mock_model(Topic, :name => "test topic 2")
  end

  let(:post) do
    mock_model(Post, :content => "stuff")
  end

  before do
    allow_message_expectations_on_nil
    assign(:forums, [forum1, forum2])
    assign(:topics, [topic1, topic2])
    assign(:forum, forum1)
    @current_user = mock_model(User, :id => 1)
    @current_user.stub!(:admin?).and_return(false)
    @club = mock_model(Club, :id => 1, :name => "test", :sub_domain => "www")
    @current_user.stub!(:club).and_return(@club)

    view.stub!(:current_user).and_return(@current_user)
    @post.stub!(:last_poster_id).and_return(@current_user.id)
    forum1.stub!(:topics).and_return(@topics)
    forum1.stub!(:most_recent_post).and_return(@post)
    forum2.stub!(:topics).and_return(@topics)
    forum2.stub!(:most_recent_post).and_return(@post)
    @topics.stub!(:count).and_return(@topics.count)
    view.stub!(:user_added_to_forum?).and_return(true)
  end

  it "renders a table with all forums" do
    render
    render.should have_selector("table")
  end

  it "renders forum name in H4 selector with forum link" do
    render
    render.should have_selector("table") do |table|
      table.should have_selector("h4") do |heading|
        heading.should have_selector("a")
      end
    end
  end

  it "renders a form with button follow when user is not following" do
    view.stub!(:user_added_to_forum?).and_return(false)
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                  :name => "commit",
                  :type => "submit",
                  :value => "follow")
    end
  end

  it "renders a form woth button unfollow when user is follow" do
    render
    rendered.should have_selector("input",
                    :name => "commit",
                    :type => "submit",
                    :value => "unfollow")
  end
end


