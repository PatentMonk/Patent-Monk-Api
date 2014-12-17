class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::StrongParameters

  acts_as_token_authentication_handler_for User
end
