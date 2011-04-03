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
    redirect_to admin_type_sejours_path, :notice => 'Le type de séjour a correctement été créé'
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = @type_sejour.errors.full_messages.first
    render :new
  end
  
  def edit
    @type_sejour = TypeSejour.find params[:id]
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Type de séjour introuvable'
    redirect_to [:admin, :type_sejours]
  end
  
  def update
    @type_sejour = TypeSejour.find params[:id]
    params[:type_sejour][:code_inchangeable] ? raise(ActiveRecord::ActiveRecordError) : @type_sejour.update_attributes!(params[:type_sejour])
    redirect_to [:admin, :type_sejours], :notice => 'Vous avez correctement mis à jour le type : ' + @type_sejour.intitule
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Type de séjour introuvable'
    redirect_to [:admin, :type_sejours]
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = @type_sejour.errors.full_messages.first
    render :edit
  rescue ActiveRecord::ActiveRecordError
    flash.now[:error] = 'Vous ne pouvez pas modifier le code inchangeable...'
    render :edit
  end

end