class ForumsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, :only => [:edit, :create, :destroy]

  def index
    if current_user.admin?
      @forums = Forum.scoped_by_club_id(current_club.id).order("name DESC")
    else
      @forums = Forum.scoped_by_club_id(current_club.id).where("admin = ?", false).order("name DESC")
    end
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    follow_val = params[:commit]
    @forum.toggle_user(current_user,follow_val)
    @forum.update_attributes(params[:forum])

    respond_to do |format|
      format.html { redirect_to "/forums" }
      format.js
    end
  end

  def destroy
    @remove =  Forum.find(params[:id])
    @remove.destroy
    flash[:success] = "Forum #{@remove.name} removed."
    redirect_to forums_path
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
    @forum = current_club.forums.build(params[:forum])
    if @forum.save
      flash[:success] = "New forum created!"
      redirect_to forums_path
    else
      @forum = []
      flash[:warning] = "Failed to Create forum"
    end
  end

  private


  def admin_user
    unless current_user.admin?
      flash[:warning] = "you can't perform this action"
      redirect_to forums_path
    end

  end
end
