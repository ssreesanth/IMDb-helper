require "csv"

class List < ApplicationRecord
  belongs_to :user
  has_many :movies, dependent: :destroy

  def self.import(file, list_id)
    CSV.foreach(file.path, headers: true) do |row|
      Movie.create!(
        title: row["Title"],
        title_type: row["Title Type"],
        imdb_rating: row["IMDb Rating"],
        genre: row["Genres"],
        year: row["Year"],
        imdb_id: row["Const"],
        list_id: list_id
      )
    end
  end
end
