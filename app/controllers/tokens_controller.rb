class TokensController < ApplicationController
def new
  @token = Token.new
end

def create
  @token = Token.new
  @token.club = current_user.club
  if @token.save
    redirect_to current_user.club
  end
end

end
