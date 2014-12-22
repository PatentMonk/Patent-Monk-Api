class Api::V1::UsersController < ApplicationController
  def index
    begin
      user = User.where(lawyer: true).joins("LEFT JOIN avatars on avatars.user_id = users.id AND avatars.main = true").joins('LEFT JOIN descriptions on descriptions.user_id = users.id').select("users.id, 
        CASE users.middle_name
        WHEN NULL
          THEN 
            CONCAT(users.first_name, ' ', users.middle_name, ' ', users.last_name) 
          ELSE
            CONCAT(users.first_name, ' ', users.last_name) 
          END as user_name, COALESCE(avatars.img_url,'https://patentmonkapi.herokuapp.com/assets/monk_head_trans.png') as img_url, 
          CASE star_count
          WHEN 0
            THEN 0
          ELSE
            star_score / star_count
          END AS star_score,
          star_count, descriptions.description, bill_per_hour")
    rescue => e
      user = []
    end
    respond_to do |format|
     format.json do
       render json: user
     end
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
