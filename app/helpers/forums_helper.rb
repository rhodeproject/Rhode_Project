module ForumsHelper
  def user_added_to_forum?
    @forum = Forum.find(params[:id])
    @forum.users.where(:id => current_user.id).present?
  end
end
