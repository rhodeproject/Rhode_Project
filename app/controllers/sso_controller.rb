class SsoController < ApplicationController
  def create
    club = Club.find_by_token(params[:session][:token])
    if club != nil
      user = User.find_by_email(params[:session][:email])
      if user != nil
        sign_in user
        flash[:success] = "Welcome #{user.name}"
        redirect_back_or root_path
      end
    end
  end
end
