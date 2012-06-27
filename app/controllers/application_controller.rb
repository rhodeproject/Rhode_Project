class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  add_breadcrumb "home", :root_path
  add_breadcrumb "forums", :forums_path


end
