class SsoController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    club = Club.find_by_token_id(params[:token])
    #if club != nil
      user = User.find_by_email(params[:email])
      #if user != nil
        sign_in user
        flash[:success] = "Welcome #{user.name}"
        render root_path
    #  end
   # end
  end
end
