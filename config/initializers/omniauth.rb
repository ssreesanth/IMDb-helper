require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_client_id"], ENV["spotify_client_secret"], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end

OmniAuth.config.allowed_request_methods = [ :post, :get ]


# user = RSpotify::User.find("1193316999")
# new_playlist = user.create_playlist!('Test Playlist IRB')
