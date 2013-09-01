class TopicsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, :only => [:edit]
  before_filter :admin_user, :only => :destroy

  def new
      @topic = Topic.new
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
    @post = @topic.posts.build(:content => params[:post][:content])
    @post.user_id = current_user.id
    @post.club_id = current_user.club_id

    respond_to do |format|
      if @post.save
        #flash[:success] = "Post Added to #{@topic.name}"
        #change this to not delay on ajax -- keeping the delay for now... this may be too much waiting for the user
        #@post.create_email_list(@topic)
        @post.delay.create_email_list(@topic)
        format.html {redirect_to("/topics/#{params[:id]}")}
        format.js {render :json => @topic,:json => @post, :include => :user}
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
    @topic = Topic.find(params[:id], :order => 'created_at DESC')
    add_breadcrumb "#{@topic.forum.name}", "/forums/#{@topic.forum_id}"
    if current_user.club_id == @topic.forum.club_id
      @posts = @topic.responses.paginate(:page => params[:page], :per_page => 10)#.includes(:user)
    else
      flash[:warning] = "You can't view this topic"
      redirect_to '/forums'
    end
  end

  def create
    forum = Forum.find(params[:topic][:forum_id])
    #forum = Forum.find(params[:forum])
    @topic = forum.topics.build(:name => params[:topic][:name],
                         :last_poster_id => current_user.id,
                         :last_post_at => Time.now)

    respond_to do |format|
      @topic.user_id = current_user.id
        if @topic.save
          @post = current_user.posts.build(:content => params[:post][:content],
                                           :topic_id => @topic.id,
                                            :club_id => current_user.club_id)

          if @post.save
            forum = @topic.forum
            forum.email_followers(@topic, @post)
              format.html{
                flash[:success] = "Successfully created topic."
                redirect_to "/forums/#{@topic.forum_id}", :only_path => true
              }
              format.js { format.js {render :json => @topic,:json => @post, :include => :user}}
          else
            format.html{render :action => 'new'}
            format.js
          end
      else
        render :action => 'new'
      end
    end
  end
end

private

def admin_user
  redirect_to(root_path) unless current_user.admin?
  flash[:warning] = "You can't delete post" unless current_user.admin?
end
