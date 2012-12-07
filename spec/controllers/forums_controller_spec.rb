require 'spec_helper'

describe ForumsController do
  render_views
  describe "GET 'edit'" do
    before do
      @forum = mock_model(Forum, :name => "Test")
    end
    it "renders the edit template" do
      @user = mock_model(User, :name => "user", :email => "foo@bar.com", :salt => "123")
      sign_in @user
      get :edit, :id => @forum
     response.should render_template("edit")
   end
  end

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
    @current_user = user
  end

  def sign_out
    current_user = nil
    @current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    return !current_user.nil?
  end
end