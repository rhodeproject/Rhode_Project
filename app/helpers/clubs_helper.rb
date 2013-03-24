module ClubsHelper
  def card_user(user)
    unless user.nil?
      return_user = user
    else
      return_user = "N/A"
    end
    return_user
  end
end
