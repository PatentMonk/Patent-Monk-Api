Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users
      devise_scope :user do
        post "login"  => "sessions#create"
        delete "logout" => "sessions#destroy"
        post "sign_up"  => "registrations#create"
      end
    end
  end

end
