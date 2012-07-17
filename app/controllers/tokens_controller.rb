class TokensController < ApplicationController
  def new
    @token = Token.new
  end

  def create
    club = Club.find(current_user.club_id)
    remove_token(club)
    @token = club.build_token
    if club.save
      club.update_attribute('token_id', @token.id)
      club.save
      redirect_to current_user.club
      flash[:success] = "SSO Token added"
    end
  end

private

  def remove_token(club)
    token = Token.find_by_club_id(club.id)
    token.destroy unless token.nil?
  end

end
