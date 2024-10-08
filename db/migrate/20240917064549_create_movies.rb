class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :title_type
      t.string :genre
      t.decimal :imdb_rating
      t.string :imdb_id
      t.integer :year
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
