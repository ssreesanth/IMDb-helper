class FreeadviseController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    url = "https://api.adviceslip.com/advice"
    advise_serialized = URI.parse(url).read
    @advise = JSON.parse(advise_serialized)
  end

end
