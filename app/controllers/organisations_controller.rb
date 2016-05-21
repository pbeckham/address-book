class OrganisationsController < ApplicationController
  
  def index
    @organisations = Organisation.all
  end

  def new
    @organisation = Organisation.new
    @organisation.build_contact_details
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
    @organisation = Organisation.find_by(id: params[:id])
  end

  def edit
    @organisation = Organisation.find_by(id: params[:id])
    if @organisation.contact_details.nil?
      @organisation.build_contact_details
    end
  end

  def update
    @organisation = Organisation.find_by(id: params[:id])
    @organisation.update(organisation_params)
    if @organisation.save
      redirect_to @organisation
    else
      render :edit
    end
  end

  def destroy
    organisation = Organisation.find_by(id: params[:id])
    if organisation.destroy
      flash[:success] = "Organisation successfully deleted"
    else
      flash[:error] = "Cannot delete organisation"
    end
    redirect_to action: :index
  end

  private

  def organisation_params
    params.require(:organisation).permit(:name, contact_details_attributes: ContactDetails::ALLOWED_ATTRIBUTES)
  end

end
