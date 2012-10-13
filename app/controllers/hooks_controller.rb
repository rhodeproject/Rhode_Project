class HooksController < ApplicationController
  require 'json'
  skip_before_filter  :verify_authenticity_token

  Stripe.api_key = "ZZkYFoDzg1jfew3Cv4HWqViVzgZpwEkj"

  def receiver
    #data_json = JSON.parse request.body.read

    if params[:type] == "charge.succeeded"
      make_active(data_event)
    end

    if params[:type] == "charge.failed"
      make_inactive(data_event)
    end
  end

  def make_active(data)
    @user = User.find_by_stripe_id(data[:id])
    @user.activate_user
  end

  def make_inactive(data)
    @user = User.find_by_stripe_id(data[:id])
    @user.inactivate_user
  end
end
