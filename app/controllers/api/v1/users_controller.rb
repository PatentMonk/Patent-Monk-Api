class Api::V1::UsersController < ApplicationController
  def index
    begin
      user = User.where(lawyer: true).joins("LEFT JOIN avatars on avatars.user_id = users.id AND avatars.main = true").joins('LEFT JOIN descriptions on descriptions.user_id = users.id').select("users.id, users.first_name, users.middle_name, users.last_name, COALESCE(avatars.img_url,'https://patentmonkapi.herokuapp.com#{asset_path('monk_head_trans.png')}') as img_url, star_count, descriptions.description, bill_per_hour")
      puts 'user'
      Rails.logger.info 'user'
      puts user
      Rails.logger.info user
      puts 'user'
      Rails.logger.info 'user'
    rescue => e
      puts 'rescue'
      Rails.logger.info 'rescue'
      puts e
      Rails.logger.info e
      merp = e
      derp = user.errors
      user = []
      puts 'rescue'
      Rails.logger.info 'rescue'
    end
    Rails.logger.info 'merp'
    Rails.logger.info merp
    Rails.logger.info 'derp'
    Rails.logger.info derp
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
