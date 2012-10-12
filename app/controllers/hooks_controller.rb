class HooksController < ApplicationController
  require 'json'

  Stripe.api_key = "ZZkYFoDzg1jfew3Cv4HWqViVzgZpwEkj"

  def receiver
    data_json = JSON.parse request.body.read

    p data_json['data']['object']['customer']

    if data_json[:type] == "invoice.payment_succeeded"
      make_active(data_event)
    end

    if data_json[:type] == "invoice.payment_failed"
      make_inactive(data_event)
    end
  end

  def make_active(data)
    @user = User.find_by_email(data['data']['object']['customer'].description)
    @user.activate_user
  end

  def make_inactive(data)
    @user = User.find_by_email(data['data']['object']['customer'].description)
    @user.inactivate_user
  end
end
