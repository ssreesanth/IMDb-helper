class ListsController < ApplicationController


  def index
    @lists = List.all
  end

  def new
    @list = List.new
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
    @filtered_movies = List.all

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
      format.html { render :index } # Ensure that the index view is rendered with filtered results
      format.turbo_stream { render turbo_stream: turbo_stream.replace('movies_list', partial: 'shared/movies_list', locals: { movies: @filtered_movies }) }
    end
  end

end
