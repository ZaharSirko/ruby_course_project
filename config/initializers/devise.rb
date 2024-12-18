Devise.setup do |config|
require "devise/orm/active_record"
config.omniauth :google_oauth2,
                ENV["GOOGLE_CLIENT_ID"],
                ENV["GOOGLE_CLIENT_SECRET"], {
                scope: "userinfo.email,userinfo.profile",
                prompt: "select_account" }
  config.sign_out_via = :delete
end
