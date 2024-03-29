# frozen_string_literal: true

# Organization model
class Organization < ApplicationRecord
  has_many :contacts
  belongs_to :account

  validates :name, :address, :tax_payer_number, presence: true
end
