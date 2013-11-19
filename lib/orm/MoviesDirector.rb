require 'active_record'

class MoviesDirector < ActiveRecord::Base
  belongs_to :director
  belongs_to :movie
end
