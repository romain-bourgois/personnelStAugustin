class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    user = User.new params[:user]
    user.save!
    redirect_to root_path, :notice => 'Vous vous êtes correctement enregistrés'
  rescue ActiveRecord::RecordInvalid
    @user = User.new
    flash.now[:error] = 'Il y a eu une erreur, vérifiez le remplissage des champs.'
    render :new
  end
  
end