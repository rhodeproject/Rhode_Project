class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:destroy]
  before_filter :correct_user, only: [:edit, :update]

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
      forum = @topic.forum
      forum.users.each do |user|
        UserMailer.delay.post_forum_notice(@topic.forum,user.email,@post)
      end
      redirect_to "/topics/#{@topic.id}"
    end
  end


  def edit
      @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    if @post.save
      flash[:success] = "Successfully updated post."
      redirect_to @post.topic
    else
      render :action => 'edit'
    end
  end

  def  show

  end

  def destroy
    @remove = Post.find(params[:id])
    @remove.destroy
    flash[:danger] = "post removed"
    redirect_to "/forums"
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
    flash[:warning] = "You can't delete post" unless current_user.admin?
  end

  def correct_user

  end

end
