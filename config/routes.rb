InternetFriendsYay::Application.routes.draw do
  resources :schedules do
    resources :people
  end
  resource :user, only: [:update]
  root to: 'welcome#show'
end
