class RenewUsersController < ApplicationController
  before_filter :correct_user

  def show
    begin
      @user = User.find(params[:id])
    rescue ActionController::Exception
      redirect_to root_path
    end
  end

  def update
    begin
      @user = User.find(params[:id])
      token = params[:stripeToken]
      message = @user.renew_membership_fee(token)
      flash[:success] = message
      re_sign_in(@user)
      redirect_to @user
    rescue Stripe::CardError => @e
      flash["credit_card"] = "Processing Error: #{@e.message}"
      redirect_to "/renew_users/#{current_user.id}"
    end
  end

  private

  def correct_user
    begin
      @user = User.find(params[:id])
      redirect_to root_path unless @user == current_user
    rescue ApplicationController::Exception
      redirect_to
    end
  end

end
