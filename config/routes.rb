Rails.application.routes.draw do
	root :to => 'grants#index'
  	resources :grants do
		collection { post :import }
		collection { delete :kill }
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
