Rails.application.routes.draw do
	devise_for :users, controllers: { sessions: 'api/v1/users/sessions',
	registrations: 'api/v1/users/registrations' }

	namespace :api do
		namespace :v1 do
			resources :tweets
			resource :users, only:[] do
				get :user_profile
				post :follow
				delete :unfollow
			end
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
