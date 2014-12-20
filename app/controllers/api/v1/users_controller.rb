class Api::V1::UsersController < ApplicationController
  def index
    respond_to do |format|
     format.json {
       render :json => {success: true, payload: User.where(lawyer: true).joins("LEFT JOIN avatars on avatars.user_id = users.id AND avatars.main = true").select("users.id, users.first_name, users.last_name, avatars.img_url")}
     }
   end
  end

  def show
    user = User.find(params[:id])
    
    respond_to do |format|
      format.json do
        if user.lawyer || current_user.id == params[:id]
          render :json => {success: true, payload: user}
        else
          render :json => {success: false}
        end
      end
    end
  end
end
