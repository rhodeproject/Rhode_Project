class SsoController < ApplicationController
  def create
    club = Club.find_by_token(params[:token])
    if club != nil
      user = User.find_by_email(params[:email])
      if user != nil
        sign_in user
        flash[:success] = "Welcome #{user.name}"
        redirect_back_or root_path
      end
    end
  end
end
