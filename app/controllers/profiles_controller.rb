class ProfilesController < ApplicationController
  before_filter :signed_in_user, :only => [:show, :edit, :update]
  #before_filter :correct_user, :only => [:edit, :update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.update_attribute('user_id', current_user.id)
    if @profile.save
      flash[:success] = "Profile created!"
      redirect_to current_user
    end
  end

  def show
    @profile = current_user.profile
  end

  def update
    dob = Date.parse(params[:date][:day] + "/" + params[:date][:month] + "/" + params[:date][:year])

    current_user.profile.update_attribute("dob",dob)
    if current_user.profile.update_attributes(params[:profile])
      flash[:success] = "Profile updated"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def edit
    @sizes = Array.new
    @sizes << RhodeProject::T_SHIRT_LARGE
    @sizes << RhodeProject::T_SHIRT_MEDIUM
    @sizes << RhodeProject::T_SHIRT_SMALL
  end

  #Private Functions
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
