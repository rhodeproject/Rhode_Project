class TopicsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
      @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    #@topics = Post.find_all_by_topic_id(params[:id])
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
            UserMailer.post_forum_notice(@topic.forum,user.email,@post).deliver
          end
            flash[:success] = "Successfully created topic."
            redirect_to "/forums/#{@topic.forum_id}"
        else
          render :action => 'new'
        end
    else
      render :action => 'new'
    end
  end
end

