class SsoController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create

    @club = Club.find_by_token_id(response.headers[:token])
    unless @club.nil?
      @user = User.find_by_email(response.headers[:email])
      unless @user.nil?
        sign_in @user
        flash[:success] = "Welcome #{@user.name}"
        #redirect_to root_path
      end
    else
      flash[:warning] = "login failure using #{params[:token]}"
      #refirect_to root_path
    end
  end
end
