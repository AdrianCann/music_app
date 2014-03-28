module SessionsHelper
  def current_user=(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end


  # def log_in_user!(user)
  #   @user = user
  #   sign_in(@user)
  #   self.current_user = @user
  # end

  def login_user!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def logout_current_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
