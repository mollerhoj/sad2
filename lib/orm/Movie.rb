class Movie < ActiveRecord::Base
  has_many :movies_genres
  has_many :roles
  has_many :actors, through: :roles
  has_many :movies_directors
  has_many :directors, through: :moviesdirectors
  #name
  #year
  #rank
end
