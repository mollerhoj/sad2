require 'active_record'

class Actor < ActiveRecord::Base
  has_many :roles
  has_many :movies, through: :roles
  #first_name
  #last_name
  #gender
  #film_count
  scope :find_by_last_name, ->(last_name) { where("last_name = ?", last_name) }

  attr_accessor :name

  def find_colleages
    colleages = []
    movies.each do |m|
      colleages << m.actors
    end
    colleages.flatten
  end
end
