class SsoController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create

    @club = Club.find_by_token_id(params[:token])
    unless @club.nil?
      @user = User.find_by_email(params[:email])
      sign_in @user
      flash[:success] = "Welcome #{@user.name}"
      redirect_to root_path
    else
      refirect_to root_path
    end
  end
end
