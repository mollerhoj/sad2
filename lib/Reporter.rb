class Reporter
  def initialize (output=nil,bacon_indexer=nil,movie_packer=nil)
    @output = output ||= STDOUT
    @bacon_indexer = bacon_indexer ||= BaconIndexer.new
    @movie_packer = movie_packer ||= MoviePacker.new
  end

  def report_bacon_index last_name
    actor = Actor.find_by_last_name last_name
    bacon_index = @bacon_indexer.index actor
    @output.puts "The bacon index of #{last_name} is #{bacon_index}"
  end

  def report_movies_fit_on_disk size
    movies = @movie_packer.pack size
    movie_names = []
    movies.each do |m|
      movie_names << m.name
    end
    @output.puts "These movies would fill up atleast half of the disk: #{movie_names.to_sentence}"
  end
end

class Output
  def messages
    @messages ||= []
  end

  def puts (message)
    messages << message
  end
end

