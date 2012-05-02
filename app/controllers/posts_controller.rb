class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
    @post = Post.new
  end

  def create

    @post = Post.new(:content => params[:post][:content])
    @post.topic_id = params[:post][:topic_id]
    @post.user_id = current_user.id

    if @post.save
      @topic = Topic.find(@post.topic_id)
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
      flash[:success] = "Successfully created post."
      redirect_to "/topics/#{@post.topic_id}"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      @topic = Topic.find(@post.topic_id)
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
      flash[:success] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end

  def  show

  end
end
