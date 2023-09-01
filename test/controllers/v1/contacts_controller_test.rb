# frozen_string_literal: true

require "test_helper"

class V1::ContactsControllerTest < ActionDispatch::IntegrationTest
  test 'should get only contacts for moonshot' do
    account = accounts(:moonshot)

    not_moonshot_contact = contacts(:two)

    get v1_contacts_path(account_id: account.id)

    contacts = JSON.parse(response.body)["data"]

    # require 'pry'; binding.pry
    contacts_ids = contacts.map { |contact| contact["id"] }

    assert_response :success
    assert_not_includes contacts_ids, not_moonshot_contact.id

  end

  test 'should create contact under the correct org' do
    account = accounts(:moonshot)
    organization = account.organizations.first

    first_name = Faker::Name.name
    last_name = Faker::Name.name

    post(
      v1_organization_contacts_path(
        account_id: account.id, 
        organization_id: organization.id
      ), 
      params: { 
        contact: { first_name: first_name, last_name: last_name }
      }
    )

    contact = JSON.parse(response.body)["data"]["contact"]

    assert_response :created

    assert_equal first_name, contact["first_name"]
  end
end
