Rails.application.routes.draw do
  root "contacts#index"

  resources :contacts do
    resources :phone_numbers, only: [:create, :destroy]
  end
end
