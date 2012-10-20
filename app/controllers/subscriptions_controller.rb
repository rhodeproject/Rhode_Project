class SubscriptionsController < ApplicationController
  def new
    #club = Club.find(current_user.club_id)
    @subscription = Subscription.new
  end

  def create
    @club = Club.find_by_sub_domain(request.subdomain)#Club.find(current_user.club_id)
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      club.update_attribute('subscription_id', @subscription.id)
      club.update_attribute('active', true)
      flash[:success] = "Thank you for subscribing!"
      #sign_in(currrent_user)
      redirect_to root_path
    else
      render :new
    end
  end
end
