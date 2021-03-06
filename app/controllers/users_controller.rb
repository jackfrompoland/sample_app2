class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  # before_filter definiuje metode, ktora bedzie wykonana zanim zostana wykonane pozostale metody
  # domyslnie before_filter bedzie stosowany dla wszystkich metod jakie mozna wywolac na kontrolerze
  # tutaj wskazujemy metody dla jakich bedzie odpalony
  # metoda ':signed_in_user' jest zdefiniowana w pliku: 'sessions_helper.rb'
  
  
  
  before_filter :correct_user,   only: [:edit, :update]  
  # correct_user jest zdefiniowany na dole pliku, metoda ta uzywa metody ' current_user?' zdefiniowanej w 'sessions_helper.rb'
  
  before_filter :admin_user,     only: :destroy
  # admin_user jest zdefiniowany na dole tego pliku
  
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
    
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def show
    @user = User.find(params[:id]) #params bierze sie z adresu wpisanego do przegladarki: users/1
    @microposts = @user.microposts.paginate(page: params[:page])
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
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user      
    else
      render 'edit'
    end
  end
  
  def index
     # @users = User.all
     @users = User.paginate(page: params[:page]) 
  end  
  
  private

    def signed_in_user
      # redirect_to signin_url, notice: "Please sign in." unless signed_in?
      # It uses a shortcut for setting flash[:notice] by passing an options hash to the redirect_to function. The code is equivalent to the more verbose
      # flash[:notice] = "Please sign in."
      # redirect_to signin_url, wymienione przez nastepujacy kod:
      
      # unless signed_in?
        # store_location
        # redirect_to signin_url, notice: "Please sign in."
      # end usuniete poniewaz dodalismy ten kod do pliku 'sessions_helper.rb'
      
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end      
    
    
end
