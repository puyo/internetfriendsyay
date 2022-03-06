Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :schedules do
    resources :people
  end
  resource :user, only: [:update]
  root to: 'welcome#show'
end
