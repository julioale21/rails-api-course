# frozen_string_literal: true

json.data do
  json.user do
    json.call(@user, :email, :authentication_token)
  end
end
