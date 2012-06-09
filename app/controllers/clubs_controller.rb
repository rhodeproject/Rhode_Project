class ClubsController < ApplicationController
  def new
    @club = Club.new
  end

  def create
    user = User.new(params[:club][:user])
    user.update_attribute('admin', true)
    @club = Club.new
    @club.name = params[:club][:name]
    @club.sub_domain = params[:club][:sub_domain]
    if @club.save
      user.club_id = @club.id
      if user.save
        flash[:success] = "Thank you for adding your club to the Rhode Project"
        sign_in user
        redirect_to user
      else
        flash[:warning] = "failed to create user"
        redirect_to root_path
      end
    else
      flash[:warning] = "failed to created club"
      redirect_to root_path
    end
  end

  def show
  end

  def index
  end
end
