# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  def current_account
    @current_account ||= Account.find(params[:account_id])
  end
end
