class Admin::UserDroitsController < Admin::ApplicationController

  def new
    @user_droit = UserDroit.new
  end

  def create
    user_droit = UserDroit.new params[:user_droit]
    user_droit.save!
    redirect_to admin_user_droits_path
  end
  
  def index
    @user_droits = UserDroit.all
  end

end