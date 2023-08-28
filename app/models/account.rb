# frozen_string_literal: true

# Account model
class Account < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :organizations

  belongs_to :owner, class_name: "User"
end
