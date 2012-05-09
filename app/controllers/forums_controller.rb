class ForumsController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @forums = Forum.all
  end

  def update
    if params[:commit] == "E-Mail Me!"
      @forum = Forum.find(params[:id])
      add_user_to_forum
    else
      if params[:commit] == "Stop E-Mails!"
        @forum = Forum.find(params[:id])
        remove_user_from_forum
        flash[:success] = "you will no longer receive email updates for #{@forum.name} forum"
      end
    end
    redirect_to @forum
  end

  def destroy
    @remove =  Forum.find(params[:id])
    @remove.destroy
    flash[:success] = "Forum #{@remove.name} removed."
    redirect_to forums_path
  end

  def show
    @forum = Forum.find(params[:id])
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      flash[:success] = "New forum created!"
      redirect_to forums_path
    else
      @forum = []
      flash[:warning] = "Failed to Create forum"
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
