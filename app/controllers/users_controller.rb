class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) #params bierze sie z adresu wpisanego do przegladarki: users/1
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user #powoduje, ze po dodaniu nowego usera zostaje on zalogowany
      flash[:success] = "Welcome to the Sample App!" #flash tworzy napis na stronie, ktory zniknie po refresh i pojawi sie tylko raz    
      redirect_to @user
    else
      render 'new' #jesli nie udalo sie dodac nowego usera to ponownie wyswietlamy new.html.erb z katalogu users
    end
  end  
  
  def edit
    @user = User.find(params[:id])
  end  
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
    else
      render 'edit'
    end
  end  
end
