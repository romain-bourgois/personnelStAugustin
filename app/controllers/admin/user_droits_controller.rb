class Admin::UserDroitsController < Admin::ApplicationController

  def new
    @user_droit = UserDroit.new
  end

  def create
    user_droit = UserDroit.new params[:user_droit]
    user_droit.save!
    redirect_to admin_user_droits_path, :notice => 'Vous avez bien ajouté le droit.'
  rescue ActiveRecord::RecordInvalid
    @user_droit = user_droit
    flash.now[:error] = 'Vous avez mal rempli un ou plusieurs champ(s)'
    render :new
  end
  
  def index
    @user_droits = UserDroit.all
  end
  
  def edit
    @user_droit = UserDroit.find params[:id]
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Le droit d\'utilisateur est introuvable'
    redirect_to admin_user_droits_path
  end
  
  def update
    user_droit = UserDroit.find params[:id]
    user_droit.update_attributes! params[:user_droit] 
    redirect_to admin_user_droits_path, :notice => 'Vous avez bien mis à jour le droit au code inchangeable "' + user_droit.code_inchangeable + '"'
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Le droit d\'utilisateur est introuvable'
    redirect_to admin_user_droits_path
  rescue ActiveRecord::RecordInvalid
    @user_droit = user_droit
    flash.now[:error] = 'Vous avez mal rempli le champ. Pour rappel, il ne peut pas être vide et ne doit pas porter un intitulé déjà existant.'
    render :edit
  end
  
  def destroy
    user_droit = UserDroit.find params[:id]
    user_droit.delete
    redirect_to admin_user_droits_path
  end

end