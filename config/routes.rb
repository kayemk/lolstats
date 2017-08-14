Rails.application.routes.draw do
  get 'overview/index'

 #resources :champions

 root 'overview#index'
end
