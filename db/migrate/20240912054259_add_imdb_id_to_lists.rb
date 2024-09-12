class AddImdbIdToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :imdb_id, :string
  end
end
