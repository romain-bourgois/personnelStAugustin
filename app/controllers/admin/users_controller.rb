class Admin::UsersController < Admin::ApplicationController

  def index
    @search = User.search params[:search]
    @users = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  def edit
    @user = User.find params[:id]
    @user_droits = UserDroit.all
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'L\'utilisateur est introuvable'
    redirect_to admin_users_path
  end
  
  def update
    @user = User.find params[:id]
    @user == current_user && params[:user][:user_droit_id] ? raise(ActiveRecord::ActiveRecordError) : @user.update_attributes!(params[:user])
    redirect_to edit_admin_user_path(@user), :notice => 'Vous avez bien mis à jour l\'utilisateur ' + @user.prenom + ' ' + @user.nom
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'L\'utilisateur est introuvable'
    redirect_to admin_users_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = @user.errors.full_messages.first
    @user_droits = UserDroit.all
    render :edit
  rescue ActiveRecord::ActiveRecordError
    flash.now[:error] = 'vous ne pouvez changer votre rôle'
    @user_droits = UserDroit.all
    render :edit
  end
  
  def destroy
    user_a_supprimer = User.find params[:id]
    user_a_supprimer == current_user ? raise(ActiveRecord::RecordInvalid.new(user_a_supprimer)) : user_a_supprimer.destroy
    redirect_to admin_users_path, :notice => 'Vous avez bien supprimé l\'utilisateur'
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'L\'utilisateur que vous voulez supprimer est introuvable'
    redirect_to admin_users_path
  rescue ActiveRecord::RecordInvalid
    flash[:error] = 'Vous essayez de supprimer votre propre utilisateur, vous ne pouvez pas faire cela!'
    redirect_to admin_users_path
  end

end