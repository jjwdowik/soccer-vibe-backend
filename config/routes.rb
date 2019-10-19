require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => redirect('/admin')

  resources :matches, only: [:index, :show]

  resources :match_twitter_vibes, only: [:index]

  mount Sidekiq::Web => '/sidekiq'

end
