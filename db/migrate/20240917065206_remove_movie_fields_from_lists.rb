class RemoveMovieFieldsFromLists < ActiveRecord::Migration[7.1]
  def change
    remove_column :lists, :title, :string
    remove_column :lists, :title_type, :string
    remove_column :lists, :genre, :string
    remove_column :lists, :year, :integer
    remove_column :lists, :imdb_id, :string
    remove_column :lists, :imdb_rating, :decimal
    remove_column :lists, :watchlist_position, :integer
    remove_column :lists, :url, :text
  end
end
