class ListsController < ApplicationController

  def index
    @lists = List.all
    @movies = Movie.all
    @list_id = params[:list_id] || current_user.lists.first&.id

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
    @filtered_list = List.find(params[:list_id])
    @filtered_movies = @filtered_list.movies.all

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
      format.turbo_stream { render turbo_stream: turbo_stream.replace('movies_list', partial: 'shared/movies_list', locals: {     movies: @filtered_movies }) }
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to imdb_path, alert: "List is deleted."
  end

  private

  def list_params
    params.permit(:name)
  end

end
