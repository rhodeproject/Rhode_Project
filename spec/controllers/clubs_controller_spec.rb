require 'spec_helper'

describe ClubsController do

  describe "POST 'create'" do

    let (:club) {mock_model(Club).as_null_object}
    before do
      Club.stub(:new).and_return(club)
    end

    it 'assigns @club to new club' do
      club.stub(:new).and_return(true)
      assigns(:club).should eq(club)
    end
  end

end