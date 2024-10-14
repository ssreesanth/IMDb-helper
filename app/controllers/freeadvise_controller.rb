class FreeadviseController < ApplicationController

  def index
    url = "https://api.adviceslip.com/advice"
    advise_serialized = URI.parse(url).read
    @advise = JSON.parse(advise_serialized)


  end

end
