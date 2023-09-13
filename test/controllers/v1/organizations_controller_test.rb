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

  test "list out organizations for account" do
    org_one = organizations(:one)
    org_two = organizations(:two)

    get v1_organizations_path(account_id: @current_account.id), headers: @headers

    organizations_ids = JSON.parse(@response.body)['data'].map do |org|
      org['id']
    end

    assert_response :success
    assert_includes organizations_ids, org_one.id
    assert_not_includes organizations_ids, org_two.id

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

  test 'should return unprocesable entity' do 
    organization_params = {
      name: Faker::Company.name,
      tax_payer_number: '',
      address: '',
    }

    post(
      v1_organizations_path(account_id: @current_account.id),
      headers: @headers,
      params: { organization: organization_params}
    )

    assert_response :unprocessable_entity
  end

end
