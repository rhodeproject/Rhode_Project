class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:destroy]
  before_filter :correct_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def index
    #TODO limit search results to current user's club
    @posts = Post.text_search(params[:query]).page(params[:page]).per_page(10)
  end

  def create
  end

  def edit
      @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    if @post.save
      flash[:success] = "Successfully updated post."
      redirect_to @post.topic, :only_path => true
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
