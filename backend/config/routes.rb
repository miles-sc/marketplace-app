Rails.application.routes.draw do
    namespace :api do
        resources :products, only: [:index]
        resources :step_files
    end
end
