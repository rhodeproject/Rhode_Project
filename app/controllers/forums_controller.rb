class ForumsController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @forums = Forum.where(:club_id => current_user.club_id)
  end

  def update
    if params[:commit] == "email updates"
      @forum = Forum.find(params[:id])
      add_user_to_forum
    else
      if params[:commit] == "stop updates"
        @forum = Forum.find(params[:id])
        remove_user_from_forum
        #flash[:warning] = "you will no longer receive email updates for #{@forum.name} forum"
      end
    end
    redirect_to "/forums"
  end

  def destroy
    @remove =  Forum.find(params[:id])
    @remove.destroy
    flash[:success] = "Forum #{@remove.name} removed."
    redirect_to forums_path
  end

  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.paginate(page: params[:page], :per_page => 10).order('updated_at DESC')
  end

  def new
    @forum = Forum.new
  end

  def create
    if current_user.admin?
      @forum = Forum.new(params[:forum])
      @forum.update_attribute('club_id',current_user.club_id)
      if @forum.save
        flash[:success] = "New forum created!"
        redirect_to forums_path
      else
        @forum = []
        flash[:warning] = "Failed to Create forum"
      end
    else
      flash[:warning] = "You must be ann admin to create a new Forum"
    end
  end

  private

  def add_user_to_forum

    @forum = Forum.find(params[:id])
    if @forum.users << current_user
      flash[:success] = "You will now receive email updates for the #{@forum.name} forum"
    else
      flash[:warning] = "There was an issue adding you the the email list for #{@forum.name} forum"
    end

  end

  def remove_user_from_forum
    @forum = Forum.find(params[:id])
    if @forum.users.delete(current_user)
      flash[:warning] = "You will no longer receive email updates for the #{@forum.name} forum"
    end
  end

end
