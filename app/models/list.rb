require "csv"

class List < ApplicationRecord
  belongs_to :user

  def self.import(file, user_id)
    CSV.foreach(file.path, headers: true) do |row|
      List.create!(
        title: row["Title"],
        url: row["URL"],
        title_type: row["Title Type"],
        imdb_rating: row["IMDb Rating"],
        genre: row["Genres"],
        year: row["Year"],
        user_id: user_id,
      )
    end
  end
end
