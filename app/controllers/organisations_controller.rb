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
      flash.now[:error] = @organisation.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    org_by_id
  end

  def edit
    org_by_id
  end

  def update
    org_by_id.update(organisation_params)
    if @organisation.save
      redirect_to @organisation
    else
      flash.now[:error] = @organisation.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if org_by_id.destroy
      flash[:success] = "Organisation successfully deleted"
    else
      flash[:error] = "Cannot delete organisation"
    end
    redirect_to action: :index
  end

  private

  def org_by_id
    @organisation = Organisation.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(:name, contact_details_attributes: ContactDetails::ALLOWED_ATTRIBUTES)
  end

end
