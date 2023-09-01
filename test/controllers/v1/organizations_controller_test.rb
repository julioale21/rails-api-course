# frozen_string_literal: true

require "test_helper"

# Organization controllerm test
class V1::OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    @current_account = accounts(:moonshot)

    @headers = {
      'X-User-Email': user.email,
      'X-User-Token': user.authentication_token
    }
  end

  test "create an organization" do

    organization_params = {
      name: Faker::Company.name,
      tax_payer_number: Faker::Company.ein,
      address: Faker::Address.street_name,

    }

    post(
      v1_organizations_path(account_id: @current_account.id),
      headers: @headers,
      params: { organization: organization_params}
    )

    organization = JSON.parse(@response.body)["data"]["organization"]


    assert_response :created
    assert organization["name"] == organization_params[:name]
  end
end
