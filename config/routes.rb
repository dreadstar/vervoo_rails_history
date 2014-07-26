ActionController::Routing::Routes.draw do |map|

  map.resources :challenges

  map.resources :user_questions

  map.resources :sponsor_questions

  map.resources :charity_questions

  map.resources :sponsors

  map.resources :charities

  map.resources :newsletter_subscribers

  map.resources :users

  map.resources :challenge_users

  map.resource :openid, :member => { :complete => :get }

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  map.namespace :manage do |manage|
    # Directs /manage/products/* to Admin::ProductsController (app/controllers/manage/products_controller.rb)
    manage.resources :index, :activities, :challenges, :charities, :charity_questions,
                     :sponsor_questions, :sponsors, :user_questions, :user_activities,
                     :user_roles, :users, :tags
    manage.root :controller => "index"
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "index"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # See how all your routes lay out with "rake routes"
  #match 'profile' => 'users#show'
  map.connect ':controller/:action/:sort/:asc'
  map.connect ':controller/:action/:sort/:asc/:offset'
  map.connect ':controller/:action/:keyword'
  map.connect ':controller/:action/:keyword/:offset'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
