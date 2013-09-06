class LeadersController < ApplicationController
  before_filter :admin_user, :only => [:edit, :create, :destroy]

  def index
    @leaders = Leader.scoped_by_club_id(current_club.id).includes(:user).order('rank ASC')
  end

  def new
    @leader = Leader.new
  end

  def edit
    @leader = Leader.find(params[:id])
  end

  def update
    @leader = Leader.find(params[:id])
    @leader.update_attribute('user_id', params[:all][:users])
    @leader.update_attributes(params[:leader])

    if @leader.save
      flash[:success] = "#{@leader.title} updated!"
    else
      flash[:waring] = "there was an issue updating #{@leader.title}"
    end

    redirect_to '/leaders'
  end

  def create
    user = User.find(params[:all][:users])

    @leader = user.leaders.build(params[:leader])
    @leader.update_attribute('club_id', current_club.id)

    if @leader.save
      flash[:success] = "#{@leader.user.name} added as #{@leader.title}!"
    else
      flash[:waring] = "falied to add leader"
    end

    redirect_to '/leaders'
  end

  def destroy
    @remove =  Leader.find(params[:id])
    @remove.destroy
    flash[:success] = "#{@remove.title} removed."
    redirect_to leaders_path
  end

  private
  def admin_user
    unless current_user.admin?
      flash[:warning] = "you can't perform this action"
      redirect_to forums_path
    end

  end
end
