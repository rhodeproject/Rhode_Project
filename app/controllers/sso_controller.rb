class SsoController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create

    #@club = Club.find_by_token_id(params[:token])
    @token = Token.find_by_api_token(params[:token])
    @user = User.find_by_email(params[:email])
    @club = Club.find_by_token_id(@token.id)
    if @user.club_id == @club.id
        sign_in @user
        flash[:success] = "Welcome #{@user.name}"
        #redirect_to root_path
    end

      #flash[:warning] = "login failure using #{params[:token]}"
      #refirect_to root_path

  end
end
