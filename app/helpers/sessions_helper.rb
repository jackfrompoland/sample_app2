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
  
  def current_user?(user)
    user == current_user
  end  
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end  
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
    # The storage mechanism is the session facility provided by Rails, which you can think of as being like an instance of the cookies variable 
    # from Section 8.2.1 that automatically expires upon browser close. We also use the request object to get the url, i.e., the URI/URL of the 
    # requested page. The store_location method puts the requested URI in the session variable under the key :return_to.    
  end
    
end
