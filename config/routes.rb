Powerphone::Engine.routes.draw do
  resource :configuration, only: %i[show update]

  get '/phone/configuration', to: 'phone#configuration'

  root to: 'phone#index'
end
