require "csv"
require "nokogiri"
require "open-uri"

class List < ApplicationRecord
  belongs_to :user
  has_many :movies, dependent: :destroy

  before_destroy :prevent_default_list_deletion


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

  private

    def prevent_default_list_deletion
      if name == "Default List"
        errors.add(:base, "Cannot delete the default list.")
        throw(:abort)
      end
    end

end
