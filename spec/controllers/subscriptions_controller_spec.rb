require 'spec_helper'

describe SubscriptionsController do

  describe "create subscription" do
    before(:each) do
      @club = mock_model(Club, :name => "Test Club", :sub_domain => "www")
      @subscription = create(:subscription)
    end

    context "fail" do
     it "should render new if subscription fails" do
        post :create
        response.should render_template("new")
      end
    end

    context "success" do
      it "should redirect to root_path" do
        @subscription.stub(:save_with_payment).and_return(true)
        @club.stub(:update_attribute).with("subscription_id", 1)
        @club.stub(:update_attribute).with('active', true)

        post :create, {:subscription => {:email => "foo@bar.com",:stripe_customer_token => "1"}}
        response.should be_success
      end
    end
  end
end
