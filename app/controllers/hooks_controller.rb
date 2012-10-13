class HooksController < ApplicationController
  require 'json'
  skip_before_filter  :verify_authenticity_token

  Stripe.api_key = "ZZkYFoDzg1jfew3Cv4HWqViVzgZpwEkj"

  def receiver
    #data_json = JSON.parse request.body.read

    if params[:type] == "charge.succeeded"
      make_active(params[:id])
    end

    if params[:type] == "charge.failed"
      make_inactive(params[:id])
    end
  end

  def make_active(id)
    @user = User.find_by_stripe_id(id)
    @user.activate_user
  end

  def make_inactive(id)
    @user = User.find_by_stripe_id(id)
    @user.inactivate_user
  end
end
