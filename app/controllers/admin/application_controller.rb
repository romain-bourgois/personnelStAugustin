class Admin::ApplicationController < ApplicationController
  before_filter :redirect_to_root_path
  
  def redirect_to_root_path
    droit = UserDroit.find_by_code_inchangeable 'admin'
    unless(current_user && current_user.user_droit == droit)
      flash[:error] = 'Vous devez être connecté en tant qu\'administrateur pour accéder à cette page'
      redirect_to root_path
    end
    true
  end
  
end