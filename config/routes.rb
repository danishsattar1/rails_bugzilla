Rails.application.routes.draw do
  devise_for :users,path: '',path_names: {sign_up: 'register', sign_in:'login', sign_out: 'logout'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects do
  	resources :bugs do
  		member do
  			patch 'change-status', to: 'bugs#changeStatus'
  		end
  	end
  	member do
  		post 'add-members', to: 'projects#createMember'
  	end
  end
  root to: "projects#index"
end
