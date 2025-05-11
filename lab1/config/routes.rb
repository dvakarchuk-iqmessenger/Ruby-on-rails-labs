Rails.application.routes.draw do
  root to: "phonebook#index"
  post "phonebook/add", to: "phonebook#add"
  post "phonebook/edit", to: "phonebook#edit"
  post "phonebook/delete", to: "phonebook#delete"
  get "phonebook/search", to: "phonebook#search"
  get "phonebook/save-json", to: "phonebook#saveJson"
  get "phonebook/save-yaml", to: "phonebook#saveYaml"
  get "phonebook/load-json", to: "phonebook#loadJson"
  get "phonebook/load-yaml", to: "phonebook#loadYaml"
  get "up" => "rails/health#show", as: :rails_health_check
end
