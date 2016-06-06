class Settings::UsersController < ApplicationController
  
  layout "sidebar"
  
  def show
    @user = User.find params[:id]
  end
  
  def edit
    @user = User.find params[:id]
  end
end
