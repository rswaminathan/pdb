Pdb::Application.routes.draw do

	get 'pages/home'
	match '/searchusers', :to => 'pages#searchusers'
	match 'searchprojects', :to => 'pages#searchprojects'
	match 'search_users', :to => 'pages#search_users'
	match 'search_projects', :to => 'pages#search_projects'
	match '/create', :to => 'pages#create'
	match '/ozzie_gooen', :to => 'users#show', :id => 2
	match '/about',   :to => 'projects#show', :id => 1
	match 'signup',	:to => 'pages#create'
	match '/contact', :to => 'pages#contact'
	match '/feed', :to => 'pages#feed'	
	match	'/login',  :to	=> 'sessions#new'
	match	'/logout', :to	=> 'sessions#destroy'
	match '/search', :to => 'projects#search', :as => :search
	root :to => "pages#home"

	resources :profile
	resources :users do
		member do
			put 'update_profile'
			get 'edit_profile'
			get :following, :followers
			get :feed
		end  
	end

  resources :admins do
    collection do
      get 'email'
      post 'send_email'
    end
  end 

	resources :sessions, :only => [:new, :create, :destroy]
	resources :relationship_users, :only => [:create, :destroy]
	resources :relationship_projects, :only => [:create, :destroy]
	resources :comments
	resources :projects do
		member do
			get 'edit_collaborators'
			post 'update_collaborators'
			post 'search_collaborators'
			delete 'delete_collaborators'
			post 'create_comment'
			get 'new_page'
			get 'new_page_section'
			post 'create_page_section'
			get 'newpage'
			post 'create_page'
			get 'edit_page'
			put 'update_page'
			post 'invite_collaborator'
			delete 'delete_page'
			get 'edit_page_section'
			put 'update_page_section'
			delete 'delete_page_section'
		end
	end
  
# The priority is based upon order of creation:
# first created -> highest priority.

# Sample of regular route:
#   match 'products/:id' => 'catalog#view'
# Keep in mind you can assign values other than :controller and :action

# Sample of named route:
#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
# This route can be invoked with purchase_url(:id => product.id)

# Sample resource route (maps HTTP verbs to controller actions automatically):
#   resources :products

# Sample resource route with options:
#   resources :products do
#     member do
#       get 'short'
#       post 'toggle'
#     end
#
#     collection do
#       get 'sold'
#     end
#   end

# Sample resource route with sub-resources:
#   resources :products do
#     resources :comments, :sales
#     resource :seller
#   end

# Sample resource route with more complex sub-resources
#   resources :products do
#     resources :comments
#     resources :sales do
#       get 'recent', :on => :collection
#     end
#   end

# Sample resource route within a namespace:
#   namespace :admin do
#     # Directs /admin/products/* to Admin::ProductsController
#     # (app/controllers/admin/products_controller.rb)
#     resources :products
#   end

# You can have the root of your site routed with "root"
# just remember to delete public/index.html.
# root :to => "welcome#index"

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id(.:format)))'
end
