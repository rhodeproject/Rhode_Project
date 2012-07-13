class TopicsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit]
  before_filter :admin_user, only: :destroy

  def new
      @topic = Topic.new
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
    @post = @topic.posts.build(:content => params[:post][:content])
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        flash[:notice] = "Post Added to #{@topic.name}"
        forum = @topic.forum
        forum.users.each do |user|
          UserMailer.delay.post_forum_notice(@topic.forum,user.email,@post)
        end
        format.html {redirect_to("/topics/#{params[:id]}")}
        format.js
      else
        format.html{render :action => "index"}
        format.js
      end
    end
  end

  def destroy
    @remove = Topic.find(params[:id])
    @remove.destroy
    flash[:warning] = "Topic #{@remove.name} removed!"
    redirect_to forum_path
  end

  def show

    @topic = Topic.find(params[:id])
    add_breadcrumb "topics", "/forums/#{@topic.forum_id}"
    if current_user.club_id == @topic.forum.club_id
      @posts = @topic.posts.paginate(page: params[:page], :per_page => 10).order('created_at ASC')
    else
      flash[:warning] = "You can't view this topic"
      redirect_to '/forums'
    end

  end

  def create
    forum = Forum.find(params[:topic][:forum_id])
    @topic = forum.topics.build(:name => params[:topic][:name],
                         :last_poster_id => current_user.id,
                         :last_post_at => Time.now)

    @topic.user_id = current_user.id
      if @topic.save
        @post = current_user.posts.build(:content => params[:post][:content],:topic_id => @topic.id)
        if @post.save
          forum = @topic.forum
          forum.users.each do |user|
            UserMailer.delay.post_forum_notice(@topic.forum,user.email,@post)
          end
            flash[:success] = "Successfully created topic."
            redirect_to "/forums/#{@topic.forum_id}", :only_path => true
        else
          render :action => 'new'
        end
    else
      render :action => 'new'
    end
  end
end

private

def admin_user
  redirect_to(root_path) unless current_user.admin?
  flash[:warning] = "You can't delete post" unless current_user.admin?
end
