module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end  
  
  def current_user=(user)
    @current_user = user #it simply defines a method current_user= expressly designed to handle assignment to current_user.
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) #wyszuka user tylko wtedy kiedy @current_user nie jest jeszcze zdefiniowany
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end  
    
end
