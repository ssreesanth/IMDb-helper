class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists do |t|
      t.string :title
      t.integer :year
      t.string :title_type
      t.string :genre
      t.decimal :imdb_rating
      t.integer :watchlist_position
      t.text :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
