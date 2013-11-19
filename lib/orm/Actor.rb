class Actor < ActiveRecord::Base
  has_many :roles
  has_many :movies, through: :roles
  #first_name
  #last_name
  #gender
  #film_count
end
