Rails.application.routes.draw do
  get 'weather2/index'
  get 'weather2/show'
  get 'weather/input'
  get 'weather/display'

  #post '/contact', to: 'contacts#create'
  #post '/weather2/show', to: 'weather2#show'


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
