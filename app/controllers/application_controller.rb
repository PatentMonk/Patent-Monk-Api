class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::StrongParameters
  puts "HEADERS"
  puts request.env.inspect
  puts "HEADERS"
  
  acts_as_token_authentication_handler_for User
end
