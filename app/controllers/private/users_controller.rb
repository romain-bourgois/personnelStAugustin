class Private::UsersController < Private::ApplicationController
  
  def edit
    @user = User.find params[:id]
  end
  
end