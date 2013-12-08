RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.run_all_when_everything_filtered = true
end
require 'Reporter'
require 'BaconIndexer'
require 'DatabaseConnector'
require 'MoviePacker'
require 'VertexCover'
require 'Graph'
require 'Node'
require 'Edge'
require 'LinKerlin'
require 'RatingParser'

require 'orm/Actor'
require 'orm/Director'
require 'orm/DirectorsGenre'
require 'orm/Movie'
require 'orm/MoviesDirector'
require 'orm/MoviesGenre'
require 'orm/Role'
