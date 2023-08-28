# frozen_string_literal: true

json.data do
  json.user do
    json.call(@user, :id, :email, :created_at, :updated_at)
  end
end
