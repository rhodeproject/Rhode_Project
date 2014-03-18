class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  add_breadcrumb "home", :root_path
  add_breadcrumb "forums", :forums_path

  def god_check
    unless current_user.email == Figaro.env.god_account
      redirect_to root_path
    end
  end
end
