# frozen_string_literal: true

##
# ApplicationController provides base functionality for all controllers
#
class ApplicationController < ActionController::Base
  # Protect from CSRF attacks - temporarily skip for debugging
  protect_from_forgery with: :null_session
end