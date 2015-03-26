Rails.application.routes.draw do
<<<<<<< Updated upstream
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'welcome#index'
=======
  devise_for :users
  #resources :users
  root 'users#index'
>>>>>>> Stashed changes

end
