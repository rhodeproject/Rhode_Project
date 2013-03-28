require 'spec_helper'

describe SponsorsController do

  describe "POST 'create'" do
    let (:sponsor) {mock_model(Sponsor).as_null_object}
    before do
      Sponsor.stub(:new).and_return(sponsor)
    end

    it 'assigns @sponsor to new sponsor' do
      sponsor.stub(:new).and_return(true)
      assigns(:sponsor).should eq(sponsor)
    end
  end
end
