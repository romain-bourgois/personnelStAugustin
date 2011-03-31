class Admin::UsersController < Admin::ApplicationController

  def index
    @search = User.search params[:search]
    @users = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  def edit
    @user = User.find params[:id]
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'L\'utilisateur est introuvable'
    redirect_to admin_users_path
  end
  
  def update
    user = User.find params[:id]
    user.update_attributes! params[:user]
    redirect_to edit_admin_user_path(user), :notice => 'Vous avez bien mis à jour l\'utilisateur ' + user.prenom + ' ' + user.nom
  end

end