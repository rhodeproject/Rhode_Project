module ForumsHelper

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

  def user_added_to_forum?
    @forum = Forum.find(params[:id])
    @forum.users.where(:id => current_user.id).present?
  end
end
