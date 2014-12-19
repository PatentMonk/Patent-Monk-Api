class Api::V1::SessionsController < Devise::SessionsController
  # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb

  # POST /resource/sign_in
  # Resets the authentication token each time! Won't allow you to login on two devices
  # at the same time (so does logout).
  def create
   self.resource = warden.authenticate!(auth_options)
   sign_in(resource_name, resource)
 
   current_user.update authentication_token: nil
   photo = current_user.avatar.where(main: true).first
   photo = photo.nil? ? asset_path('monk_head_trans.png') : photo.img_url
   respond_to do |format|
     format.json {
       render :json => {
          id: current_user.id,
          username: (current_user.first_name + ' ' + current_user.middle_name + ' ' + current_user.last_name).squish,
          token: current_user.authentication_token,
          about_me: current_user.description.description,
          profile_photo: photo,
          backgrond_photo: '',
          is_banned: 0,
          status: 1,
          added: current_user.created_at,
          updated: nil,
          success: true
       }
     }
   end
  end

  # DELETE /resource/sign_out
  def destroy
 
   respond_to do |format|
     format.json {
       if current_user
         current_user.update authentication_token: nil
         signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
         render :json => {}.to_json, :status => :ok
       else
         render :json => {}.to_json, :status => :unprocessable_entity
       end
       

     }
   end
  end
end