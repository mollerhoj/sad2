require 'active_record'

class Director < ActiveRecord::Base
  has_many :directors_genres
  has_many :movies_directors
  has_many :movies, through: :movies_directors
  #first_name
  #last_name
end
