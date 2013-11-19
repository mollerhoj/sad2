require 'active_record'

class Actor < ActiveRecord::Base
  has_many :roles
  has_many :movies, through: :roles
  #first_name
  #last_name
  #gender
  #film_count
  attr_accessor :name
end
