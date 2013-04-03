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
      # Handle a successful save.
    else
      render 'new'
    end
  end  
end