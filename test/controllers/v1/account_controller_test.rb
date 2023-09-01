# frozen_string_literal: true

class V1::AccountControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)

    @headers = {
      'X-User-Email': user.email,
      'X-User-Token': user.authentication_token
    }
  end

  test "create account for user" do
    account_params = {
      name: Faker::Company.name,
      tax_payer_id: Faker::Company.ein,
      var_rate: 7.0,
      address: Faker::Address.street_name,
      default_currency: "USD"
    }

    post(
      v1_accounts_path,
      headers: @headers,
      params: { account: account_params }
    )

    account = JSON.parse(response.body)['data']['account']

    assert_response :success
    assert account['name'] == account_params[:name]
  end
end
