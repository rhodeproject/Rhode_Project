class HooksController < ApplicationController
  require 'json'
  skip_before_filter  :verify_authenticity_token

  Stripe.api_key = "ZZkYFoDzg1jfew3Cv4HWqViVzgZpwEkj"

  def receiver
    #data_json = JSON.parse request.body.read
    @user = User.find_by_stripe_id(params[:id])
    if params[:type] == "charge.succeeded" && !@user.nil?
      make_active(@user)
    end

    if params[:type] == "charge.failed" && !@user.nil?
      make_inactive(@user)
    end
  end

  def make_active(user)
    user.activate_user
  end

  def make_inactive(user)
    user.inactivate_user
  end
end
