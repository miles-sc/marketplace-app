Rails.application.routes.draw do
    namespace :api do
        resources :products, only: [:index]
        resources :step_files, only: [:create]
        resources :step_jobs, only: [:create, :show] do
            member do
                get "files/*filename", to: "step_jobs#file"
            end
        end
    end
end
