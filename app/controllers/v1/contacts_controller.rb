# frozen_string_literal: true

# Contacts endpoints
class V1::ContactsController < ApplicationController
  include V1::Contacts::Response

  def index
    @contacts = current_account.contacts

    render :index, status: :ok
  end

  def create
    @contact = organization.contacts.build(contact_params)

    create_and_render_contact(@contact) || render_invalid_response
  end

  def destroy
    contact = organization.contacts.find(params[:id])

    destroy_and_render_contact(contact) || render_invalid_response
  end

  def update
    contact = organization.contacts.find(params[:id])

    update_and_render_contact(contact, contact_params) ||
      render_invalid_response
  end

  private

  def organization
    @organization ||= current_account.organizations.find(params[:organization_id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email)
  end
end
