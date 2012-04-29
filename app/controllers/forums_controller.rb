class ForumsController < ApplicationController
  #before_filter :admin_user, only: [:destroy, :new]


  def index
    @forums = Forum.all
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
end
