class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    user = User.new params[:user]
    user.save!
    redirect_to root_path, :notice => 'Vous vous êtes correctement enregistrés'
  end
  
end