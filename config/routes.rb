Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    member do
      get 'json_ld', to: 'recipes#json_ld'
    end
  end
end
