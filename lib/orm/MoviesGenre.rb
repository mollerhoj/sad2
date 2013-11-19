require 'active_record'

class MoviesGenre < ActiveRecord::Base
  belongs_to :movie
  #genre
end
