class HooksController < ApplicationController
  require 'json'
  skip_before_filter  :verify_authenticity_token

  Stripe.api_key = Figaro.env.stripe_api_key

  def receiver
    @user = User.find_by_stripe_id(params[:id])

    if params[:type] == "charge.succeeded" && !@user.nil?
      @user.update_attribute('active', true)
    end

    if params[:type] == "charge.failed" && !@user.nil?
      @user.update_attribute('active', false)
    end
  end

  def subscription
    @club = Club.find_by_subscription_id(params[:customer])
    @club.send_subscription_update(params[:type], params[:amount])
  end

end
