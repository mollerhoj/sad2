require 'active_record'

class DirectorsGenre < ActiveRecord::Base
  belongs_to :director
  #genre
  #prob (unknown meaning)
end
