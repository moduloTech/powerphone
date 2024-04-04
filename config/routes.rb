Powerphone::Engine.routes.draw do
  resource :configuration, only: %i[show update]

  root to: 'phone#index'
end
