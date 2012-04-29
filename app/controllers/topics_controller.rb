class TopicsController < ApplicationController
  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      flash[:success] = "New forum created!"
      redirect_to forums_path
    else
      @topic = []
      flash[:warning] = "Failed to Create forum"
    end
  end

  def index

  end
end
