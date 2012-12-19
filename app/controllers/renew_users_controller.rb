class RenewUsersController < ApplicationController
  before_filter :correct_user

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    token = token = params[:stripeToken]
    message = @user.renew_membership_fee(token)
    flash[:success] = message
    re_sign_in(@user)
    redirect_to @user
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end

end
