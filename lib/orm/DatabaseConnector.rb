require 'active_record'

class DatabaseConnector

  def initialize logger
    @logger = logger ||= STDOUT
  end

  #TODO: use logger
  #ActiveRecord::Base.logger = Logger.new(STDERR)
   
  ActiveRecord::Base.establish_connection(
      :adapter => "mysql",
      :database  => "test"
  )
end

# require_relative "Actor"
# #Find actor
# puts Actor.find(358968).last_name
# 
# require_relative "Role"
# 
# puts Actor.find(358968).roles.inspect
# 
# require_relative "Movie"
# 
# puts Actor.find(358968).movies.inspect

# #Find director
# puts Director.find(15092).last_name
# puts Director.find(15092).directors_genre.inspect
# 
# puts Director.find(15092).movies_directors.inspect
# puts Director.find(15092).movies.inspect
# 
# puts Director.find(15092).directors_genres.genre
# 
# #Find movie
# puts Movie.find(130128).name
# puts Movie.find(130128).roles.inspect
# puts Movie.find(130128).actors.inspect


