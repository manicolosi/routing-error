# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_so_clone_session',
  :secret      => 'b9cf16f5ff0a6b44cc0f57a9d83db336e91569f40f97b458ec71c54a59a2edf5e428a50cee5ef7ec2077886787513c622a96ccbea9dce7b2823d8ede09a83992'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
