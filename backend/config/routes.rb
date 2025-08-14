Rails.application.routes.draw do
    namespace :api do
        resources :products, only: [:index]
        resources :step_files, only: [:create]
        resources :step_jobs, only: [:create]
    end
end
