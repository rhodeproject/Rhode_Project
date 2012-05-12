module ForumsHelper
  def user_added_to_forum?(forum)

    @forum = Forum.find(forum.id)
    @forum.users.where(:id => current_user.id).present?
  end

  def latest_poster(user)
    @user = User.find(user)
  end
end
