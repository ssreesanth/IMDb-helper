require "nokogiri"
require "open-uri"
require 'rspotify'

class ListsController < ApplicationController
  def index
    @lists = current_user.lists
    @movies = Movie.all
    @list = List.find_by(params[:list_id])
  end

  def fluxindex
    url = "https://archiv.fluxfm.de/fluxfm-playlist/?loc=berlin&date=2024-09-29&ajax=1&days=30&limit=30"
    html = URI.open(url)
    doc = Nokogiri::HTML.parse(html)
    @songs = doc.search(".title")

    @user = RSpotify::User.find("1193316999")
    # playlist = @user.create_playlist!('FluxFm Top 30')
    # songs.each do |song|
    #   # Search for the song on Spotify
    #   tracks = RSpotify::Track.search(song)
    #   playlist.add_tracks!(tracks)
    # end
  end

  def import_and_create
    @list = List.new(list_params) # Uses list_params to get the list's name
    @list.user = current_user # Assign the current user to the list
    @list.save
    if params[:file].present?
      List.import(params[:file], @list.id) # Pass the file and the list to the import method
      redirect_to imdb_path, notice: "List and movies imported successfully"
    else
      @list.destroy
      redirect_to imdb_path, alert: "No file selected. List creation canceled."
    end
  end

  def filter
    if params[:list_id].present?
      @list = List.find(params[:list_id])
      @filtered_movies = @list.movies.all

      if params[:min_imdb_rating].present? && params[:max_imdb_rating].present?
        min_rating = params[:min_imdb_rating]
        max_rating = params[:max_imdb_rating]
        @filtered_movies = @filtered_movies.where("imdb_rating BETWEEN ? AND ?", min_rating, max_rating)
      end

      if params[:genre].present?
        genre = params[:genre].capitalize
        @filtered_movies = @filtered_movies.where("genre LIKE ?", "%#{genre}%")
      end

      if params[:media].present?
        @filtered_movies = @filtered_movies.where("title_type = ?", params[:media])
      end

      respond_to do |format|
        format.html { render :index }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('movies_list', partial: 'shared/movies_list', locals: { movies: @filtered_movies }) }
      end
    else
      redirect_to imdb_path, alert: "No List selected. Please select a list."
    end
  end

  def destroy
    @list = List.find(params[:id])
    if @list.destroy
      redirect_to imdb_path, alert: "List is deleted."
    else
      redirect_to imdb_path, alert: @list.errors.full_messages.to_sentence
    end
  end

  private

  def list_params
    params.permit(:name)
  end

end
