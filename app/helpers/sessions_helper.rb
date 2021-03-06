module SessionsHelper
  def sign_in(user)
    if user.anniversary.past?
      flash[:warning] = "Your account has expired"
    else
      cookies.permanent[:remember_token] = user.remember_token
      current_user = user
      flash[:success] = "Welcome back #{user.name}"
    end
  end

  def re_sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end
  def sign_in_first_time(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def account_past_due?(user)
    user.anniversary < Date.today
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def current_club=(club)
    @current_club = club
  end

  def current_club
    @current_club ||= Club.find_by_sub_domain(request.subdomain)
  end

  def current_club?(club)
    club == current_club
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end


  def store_location
    session[:return_to] = request.fullpath
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, :notice => "Please sign in."
    end
  end

  private

    def user_from_remember_token
      remember_token = cookies[:remember_token]
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end

    def clear_return_to
      session.delete(:return_to)
    end
end
