class MembershipsController < ApplicationController

  def create
    Organisation::Membership.create(membership_params)
    render organisation
  end

  def destroy
    organisation.membership.where(id: params[:id]).destroy
  end

  private

  def organisation
    Organisation.where(id: params[:organisation_id])
  end

  def membership_params
    params.require(:membership).allow(:user_id, :organisation_id)
  end

end
