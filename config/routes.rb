Rails.application.routes.draw do

	root "home#index"

	get "/about" => "home#about"

	resources :tasks

	resources :projects do
		resources :discussions, only: [:create, :update, :edit, :destroy]
	end

	resources :discussions, only: [] do
 		 resources :comments, only: [:create, :update, :edit, :destroy]
	end

	
end