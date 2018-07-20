Rails.application.routes.draw do
  root to: 'rates#calcular'
  resources :rates
  get "calcula/taxa", to: "rates#calcular"
  post "calcula/taxa", to: "rates#calculo"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
