Rails.application.routes.draw do

  	devise_for :users, :controllers => { :registrations => "registrations" }

	root "home#index"

	get "/about" => "home#about"

	resources :projects do
		resources :discussions, only: [:create, :update, :edit, :destroy]
		resources :tasks do
			member do
			patch :mark_complete
			patch :mark_incomplete
			end
		end
	end

	resources :discussions, only: [] do
 		 resources :comments, only: [:create, :update, :edit, :destroy]
	end

	
end