require "csv"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :lists, dependent: :destroy

  after_create :create_default_list

  private

  def create_default_list
    default_list = lists.create(name: "Default List", user: self)

    file_path = "db/storage/Default-Watchlist.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Movie.create!(
        title: row["Title"],
        title_type: row["Title Type"],
        imdb_rating: row["IMDb Rating"],
        genre: row["Genres"],
        year: row["Year"],
        imdb_id: row["Const"],
        list_id: default_list.id
      )
    end
  end

end
