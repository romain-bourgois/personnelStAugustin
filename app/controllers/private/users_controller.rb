class Private::UsersController < Private::ApplicationController
  
  def edit
  end
  
  def update
    user = User.find params[:id]
    user.update_attributes! params[:user]
    redirect_to edit_private_user_path(user), :notice => 'Vous avez bien mis à jour votre profil'
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = user.errors.full_messages.first
    render :edit
  end
  
end