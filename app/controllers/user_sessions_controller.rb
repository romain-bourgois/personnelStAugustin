class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new params[:user_session]
    @user_session.save!
    redirect_to root_path, :notice => "Vous vous êtes connecté avec succès"
  rescue Authlogic::Session::Existence::SessionInvalidError
    flash.now[:error] = "Vous n'êtes pas connecté, vérifiez votre login et mot de passe"
    render :new
  end

  
end