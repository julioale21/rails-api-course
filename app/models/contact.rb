# frozen_string_literal: true

# Contact model
class Contact < ApplicationRecord
  belongs_to :organization
end
