class ForumsController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @forums = Forum.scoped_by_club_id(current_user.club_id)
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    if params[:commit] == "follow"
      add_user_to_forum
    elsif params[:commit] == "unfollow"
      remove_user_from_forum
    end

    @forum.update_attributes(params[:forum])

    respond_to do |format|
      format.html { redirect_to "/forums" }
      format.js
    end
  end

  def destroy
    if current_user.admin?
      @remove =  Forum.find(params[:id])
      @remove.destroy
      flash[:success] = "Forum #{@remove.name} removed."
      redirect_to forums_path
    else
      flash[:warning] = "You do not have rights to remove this forum"
      redirect_to '/forums'
    end
  end

  def show
    @forum = Forum.find(params[:id])
    @topic = Topic.new
    add_breadcrumb "#{@forum.name}", :forum_path, :title => "topics"
    if current_user.club_id != @forum.club_id
      flash[:warning] = "You do not have access to this forum"
      redirect_to "/forums"
    end
    @topics = @forum.topics.paginate(:page => params[:page], :per_page => 10).order('updated_at DESC').includes(:user)
  end

  def new
    if current_user.admin?
      @forum = Forum.new
    else
      redirect '/forums'
    end
  end

  def create
    if current_user.admin?
      club = Club.find(current_user.club_id)
      @forum = club.forums.build(params[:forum])
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
      flash[:success] = "You will no longer receive email updates for the #{@forum.name} forum"
    end
  end

end
