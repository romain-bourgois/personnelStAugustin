class Admin::TypeSejoursController < Admin::ApplicationController

  def index
    @type_sejours = TypeSejour.all
  end
  
  def new
    @type_sejour = TypeSejour.new
  end
  
  def create
    @type_sejour = TypeSejour.new params[:type_sejour]
    @type_sejour.save!
    redirect_to admin_type_sejours_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = @type_sejour.errors.full_messages.first
    render :new
  end

end