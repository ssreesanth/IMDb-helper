require "csv"
class Movie < ApplicationRecord
  belongs_to :list
end
