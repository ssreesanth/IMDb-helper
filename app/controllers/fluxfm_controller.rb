class FluxfmController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    date = params[:date].presence || Date.today
    url = "https://archiv.fluxfm.de/fluxfm-playlist/?loc=berlin&date=#{date}&ajax=1&days=30&limit=30"
    puts "Generated URL: #{url}"
    html = URI.open(url)
    doc = Nokogiri::HTML.parse(html)
    @songs = doc.search(".title")


    # @user = RSpotify::User.find("1193316999")
    # playlist = @user.create_playlist!('FluxFm Top 30')
    # songs.each do |song|
    #   # Search for the song on Spotify
    #   tracks = RSpotify::Track.search(song)
    #   playlist.add_tracks!(tracks)
    # end
  end

end
