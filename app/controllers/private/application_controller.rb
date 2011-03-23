class Private::ApplicationController < ApplicationController
  before_filter :redirect_to_root_path
  
  def redirect_to_root_path
    redirect_to root_path, :error => 'Vous devez être connecté pour accéder à cette page' unless current_user
    true
  end
  
end