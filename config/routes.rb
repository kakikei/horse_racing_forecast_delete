Rails.application.routes.draw do
  root 'horses#index'
  resources :horses, only: :show
  post '/access_site', to: "horses#access_site"
end
