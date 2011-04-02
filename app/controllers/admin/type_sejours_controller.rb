class Admin::TypeSejoursController < Admin::ApplicationController

  def index
    @type_sejours = TypeSejour.all
  end
  
  def new
    @type_sejour = TypeSejour.new
  end

end