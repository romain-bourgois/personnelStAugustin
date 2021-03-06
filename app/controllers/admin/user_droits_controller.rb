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
    @user_droit = UserDroit.find params[:id]
    params[:user_droit][:code_inchangeable] ? raise(ActiveRecord::ActiveRecordError) : @user_droit.update_attributes!(params[:user_droit])
    redirect_to admin_user_droits_path, :notice => 'Vous avez bien mis à jour le droit au code inchangeable "' + @user_droit.code_inchangeable + '"'
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Le droit d\'utilisateur est introuvable'
    redirect_to admin_user_droits_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Vous avez mal rempli le champ. Pour rappel, il ne peut pas être vide et ne doit pas porter un intitulé déjà existant.'
    render :edit
  rescue ActiveRecord::ActiveRecordError
    flash.now[:error] = 'Vous ne pouvez pas modifier le code inchangeable...'
    render :edit
  end
  
  def destroy
    user_droit = UserDroit.find params[:id]
    raise ActiveRecord::ActiveRecordError if user_droit.code_inchangeable == 'admin' || user_droit.code_inchangeable == 'mono'
    droit_par_default = UserDroit.find_by_code_inchangeable 'mono'
    users_a_modifier = User.where(:user_droit_id =>  user_droit.id)
    users_a_modifier.each do |user|
      user.update_attribute :user_droit, droit_par_default
    end
    user_droit.delete
    redirect_to admin_user_droits_path, :notice => 'La suppression s\'est correctement déroulée. Les utilisateurs qui avaient le droit "' + user_droit.intitule + '" ont à présent le droit "' + droit_par_default.intitule + '"'
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Il y a eu une erreur : un droit d'utilisateur n'a pas pu être trouvé en base. Pas de supression"
    redirect_to admin_user_droits_path
  rescue ActiveRecord::ActiveRecordError
    flash[:error] = "Vous ne pouvez pas détruire le droit #{user_droit.intitule} car la matrice exploserait!"
    redirect_to admin_user_droits_path
  end

end