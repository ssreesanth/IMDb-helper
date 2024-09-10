class ListsController < ApplicationController


  def index
    @lists = List.all
  end



  def import_and_create
    if params[:file].present?
      List.import(params[:file], current_user.id)
      redirect_to imdb_path, notice: "List imported successfully"
    else
      redirect_to imdb_path, notice: "No files selected"
    end
  end

  def filter

    @filtered_movies = List.where("imdb_rating >= ?", params[:imdb_rating])
    @filtered_movies = List.where("genre >= ?", params[:genre])

    respond_to do |format|
      format.html { render :index } # Ensure that the index view is rendered with filtered results
      format.turbo_stream { render turbo_stream: turbo_stream.replace('movies_list', partial: 'lists/movies_list', locals: { movies: @filtered_movies }) }
    end
  end







end
