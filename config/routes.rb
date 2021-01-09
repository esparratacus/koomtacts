Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  scope module: 'users' do
    resources :contacts_files do
      member do
        get 'execute_import'
      end
    end
    resources :contacts , only:[:index]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
