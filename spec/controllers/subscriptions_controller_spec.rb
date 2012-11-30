require 'spec_helper'

describe SubscriptionsController do

  describe "create subscription" do
    before(:each) do
      @club = mock_model(Club, :name => "Test Club", :sub_domain => "www")
      @subscription = mock_model(Subscription)
    end

    context "fail" do
     it "should render new if subscription fails" do
        post :create
        response.should render_template("new")
      end
    end

    context "success" do
      it "should create a new subscription"
      it "should redirect to root_path" do
        @subscription = Subscription.should_receive(:new).
            with("club_id" => "1","email" => "foo@bar.com", "stripe_customer_token" => "1" , "stripe_card_token" => "123")
        @subscription.should_receive(:save_with_payment).and_return(true)
        @club.should_receive(:update_attribute).with("subscription_id", 1)
        @club.should_receive(:update_attribute).with('active', true)

        post :create, {:subscription => {:club_id => 1,:email => "foo@bar.com",:stripe_customer_token => "1",:stripe_card_token => "123"}}
        flash[:success].should eq("Thank you for subscribing!")
      end
    end
  end
end
