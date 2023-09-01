# frozen_string_literal: true

# Organization controller
class V1::OrganizationsController < ApplicationController
  def create
    organization = current_account.organizations.build(organization_params)

    if organization.save
      render :create, locals: { organization: organization }, status: :created
    else
      render json: { errors: organization.errors.messages },
             status: :unprocessable_entity
    end
  end

  def organization_params
    params.require(:organization).permit(:name, :tax_payer_number, :address)
  end
end
