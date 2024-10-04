require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_client_id"], ENV["spotify_client_secret"], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end

OmniAuth.config.allowed_request_methods = [ :post, :get ]



# RSpotify.authenticate("9cc2d3bdbdf146cbbd2e80b219239dc3", "3d207e6433444d8581ffffe10727c11f")
# user = RSpotify::User.find("1193316999")
# new_playlist = user.create_playlist!('Test Playlist IRB')

