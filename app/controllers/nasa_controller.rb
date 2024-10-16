class NasaController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    api_key = ENV["NASA_API"]
    date = params[:date].presence || Date.today
    url = "https://api.nasa.gov/planetary/apod?api_key=#{api_key}&start_date=#{date}"
    image_serialized = URI.parse(url).read
    @image = JSON.parse(image_serialized)
  end

end
