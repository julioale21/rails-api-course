# frozen_string_literal: true

json.data do
  json.account do
    json.call(@account, :id, :name)
  end
end
