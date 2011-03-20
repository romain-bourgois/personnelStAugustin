class Private::UserSessionsController < Private::ApplicationController
  
  def destroy
    current_user_session.destroy
    redirect_to root_path
  end
  
end