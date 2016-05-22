class MembershipsController < ApplicationController

  def new
    @membership = organisation.memberships.build
  end

  def create
    if organisation.memberships.create(membership_params)
      redirect_to organisation_path(@organisation)
    else
      flash[:error] = "Unable to create membership"
      render :new
    end
    
  end

  def destroy
    membership = organisation.memberships.where(id: params[:id]).first
    unless membership.destroy
      flash[:error] = "Error deleting membership"
    end
    redirect_to organisation
  end

  def people_options
    Person
      .where.not(id: organisation.memberships.select(:person_id))
      .select(:first_name, :last_name, :id)
      .map { |p| [ p.full_name, p.id ] }
  end
  helper_method :people_options

  private

  def organisation
    @organisation ||= Organisation.find(params[:organisation_id])
  end

  def membership_params
    params.require(:organisation_membership).permit(:person_id)
  end

end
