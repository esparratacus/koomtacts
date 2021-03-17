Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: "home#index"
  scope module: 'users' do
    resources :contacts_files do
      member do
        get 'execute_import'
      end
    end
    resources :contacts, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        collection do
          post :sign_in, to: 'users#sign_in'
        end
      end
      resources :contacts, only: %i[index]
      resources :contacts_files, except: %i[new edit show]
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
