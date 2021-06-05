Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :subscriptions, only: [:create, :destroy]
    end
  end
  get '/api/v1/customer/:id/subscriptions', to: 'api/v1/subscriptions#index'
  get '/performance_tests', to: 'performance_tests#index'
end
