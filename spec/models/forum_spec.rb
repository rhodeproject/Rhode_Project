require 'spec_helper'

describe Forum do
  before(:each) do
    @forum = Forum.new(:name => "Test Forum")
    @user = FactoryGirl.build(:user)
    @user.update_attribute('admin',false)
  end

  it "should be valid with valid attributes" do
    @forum.should be_valid
  end

  context "toggle users following forum" do
    it "should start with no followers" do
      @forum.users.should be_empty
    end

    context "when a user is not following" do
      it "should add user when toggle_user is called" do
        @forum.toggle_user(@user, "follow")
        @forum.users.should include(@user)
      end
    end

    context "when a user is following" do
      before(:each) do
        @user2 = FactoryGirl.build(:user)
        @user.update_attribute('admin',false)
        @forum.toggle_user(@user2,"follow")
      end

      it "should remove user when toggle_user is called" do
        @forum.toggle_user(@user2,"unfollow")
        @forum.users.should_not include(@user2)
      end
    end
  end


end