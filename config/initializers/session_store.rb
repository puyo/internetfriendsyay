# Be sure to restart your server when you modify this file.

InternetFriendsYay::Application.config.session_store :cookie_store, key: '_internetfriendsyay_session', secure: Rails.env.production?

Rails.application.config.action_dispatch.cookies_same_site_protection = :lax

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# InternetFriendsYay::Application.config.session_store :active_record_store
