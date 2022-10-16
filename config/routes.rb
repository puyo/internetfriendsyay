Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  constraints(host: /internetfriendsyay.herokuapp.com/) do
    match '/(*path)' => redirect {|params, req| "https://internetfriendsyay.com/#{params[:path]}"},  via: [:get, :post]
  end

  resources :schedules do
    resources :people
  end
  resource :user, only: [:update]
  root to: 'welcome#show'
end
