require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#main'

  resources :matches, only: [:index, :show]

  resources :match_twitter_vibes, only: [:index]

  mount Sidekiq::Web => '/sidekiq'

end
