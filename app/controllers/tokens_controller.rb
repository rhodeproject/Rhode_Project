class TokensController < ApplicationController
def new
  @token = Token.new
end

def create
  club = Club.find(current_user.club_id)
  @token = club.build_token
  if club.save
    club.update_attribute('token_id', @token.id)
    club.save
    redirect_to current_user.club
    flash[:success] = "SSO Token #{@token.api_token} has been added to #{club.name}"
  end
end

end
