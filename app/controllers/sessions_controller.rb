class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user #rails jest na tyle sprytne, ze otworzy odpowiednia strone 
      #redirect_to user
      redirect_back_or user
      # To implement the forwarding itself, we use the redirect_back_or method to redirect to the requested URI if it exists, or some default URI 
      # otherwise, which we add to the Sessions controller create action to redirect after successful signin      
      
    else
      flash.now[:error] = 'Invalid email/password combination' #flash.now powoduje, ze wyswietli sie komunikat, ktory zniknie gdy tylko wyjdziemy z wybranej strony
                                                               #flash znika jesli pojawia sie nowy 'request' jak refresh. Re-rendering a template with render doesn’t count as a request.   
      render 'new' #poniewaz jestesmy w sessions to 'new' wyswietli plik 'new.html.erb'
    end
  end

  def destroy
    sign_out
    redirect_to root_url    
  end
end
