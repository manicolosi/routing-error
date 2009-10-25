ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.resources :user_sessions
  map.resources :users

  map.resources :questions, :has_many => [ :answers, :votes ]

  map.root :questions
end
