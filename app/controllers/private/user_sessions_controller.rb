class Private::UserSessionsController < Private::ApplicationController
  
  def destroy
    current_user_session.destroy
    redirect_to root_path, :notice => "Vous vous êtes correctement déconnecté"
  end
  
end