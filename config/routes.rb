Rails.application.routes.draw do
  namespace :admin do
    root "application#index"

    resources :projects, except: [:index, :show]
    resources :states, only: [:index, :new, :create]
    resources :users do
      member do
        patch :archive
      end
    end
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "projects#index"

  # resources :projects, only: [:index, :show, :edit, :update] do
  #   resources :tickets
  # end

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
        post :upload_file
      end
    end
  end

  scope path: "tickets/:ticket_id", as: :ticket do
    resources :comments, only: [:create]
  end
end
