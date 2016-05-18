class OrganisationsController < ApplicationController
  
  def index
    @organisations = Organisation.all
  end

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.create(organisation_params)
    if @organisation.save
      redirect_to @organisation
    else
      render :new
    end
  end

  def show
    @organisation = Organisation.find(id: params[:id])
  end

  def edit
    @organisation = Organisation.find(id: params[:id])
    @organisation.update(organisation_params)
    if @organisation.save
      redirect_to @organisation
    else
      render :edit
    end
  end

  private

  def organisation_params
    params.require(:organisation).permit(:name)
  end

end
