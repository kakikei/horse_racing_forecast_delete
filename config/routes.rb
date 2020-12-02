Rails.application.routes.draw do
  root 'horses#index'
  post '/access_site', to: "horses#access_site"
end
