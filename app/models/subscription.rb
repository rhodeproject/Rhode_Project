class Subscription < ActiveRecord::Base
  attr_accessible :club_id, :email, :stripe_customer_token, :stripe_card_token
  attr_accessor :stripe_card_token

  has_many :clubs

  def save_with_payment
    if valid?
      Stripe.api_key = STRIPE_API_KEY
      customer = Stripe::Customer.create(description: email, plan: 1, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
