class CustomAuthFailure < Devise::FailureApp
  def respond
    puts "HEADERS"
    puts request.env.inspect
    puts "HEADERS"
    
    
    self.status = 401 
    self.content_type = 'json'
    self.response_body = {'success' => false,"errors" => ["Invalid login credentials"]}.to_json
  end 
end