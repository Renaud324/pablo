# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV['GOOGLE_OAUTH_CLIENT_ID'], ENV['GOOGLE_OAUTH_CLIENT_SECRET'], {
#     scope: 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/gmail.readonly',
#     access_type: 'offline',
#     prompt: 'consent'
#   }
# end
