Rails.application.routes.draw do
  get 'welcome/index'

  resources :points

  root 'welcome#index'  

end
