# frozen_string_literal: true

# Contacts endpoints
class V1::ContactsController < ApplicationController
  def index
    @contacts = account.contacts

    render :index, status: :ok
  end

  def create
    @contact = organization.contacts.build(contact_params)

    if @contact.save
      render :create, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def destroy
    @contact = organization.contacts.find(params[:id])

    if @contact.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def update
    @contact = organization.contacts.find(params[:id])

    if @contact.update(contact_params)
      render :update, status: :ok
    else
      head(:unprocessable_entity)
    end
  end

  private

  def organization
    @organization ||= account.organizations.friendly.find(params[:organization_id])
  end

  def account
    @account ||= Account.friendly.find(params[:account_id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email)
  end
end
