class RatingParser

  attr_reader :users
  attr_reader :films
  attr_accessor :connections

  def initialize
    @users = []
    @films = []
    @connections = {}
  end

  def parse path
    structure path
    build
    uncontract
    build_graph
  end

  def structure path
    file = File.new(path)
    file.each_line do |line|
      read line
    end
    file.close
  end

  def build
    k = @films.select {|f| !f.nil? }
    k.each do |f|
      connect f.create_connections
    end
  end

  def build_graph
    graph = Graph.new
    @connections.each do |e,weight|
      graph.build_edge e[0],e[1],{w:weight}
    end
    graph
  end

  def uncontract
    @connections.each do |key,ratings|
      @connections[key] = ratings.inject(:+)
      @connections[key] = @connections[key].to_f/ratings.size
    end
  end

  def connect con
    @connections.merge!(con) do |k,v1,v2|
      v1 + v2
    end
  end

  private
  def read line
    case line
    when /^(\d+)::(\d+)::(\d+)::(\d+)/
      id = $1.to_i-1
      fid = $2.to_i-1

      if @users[id].nil?
        @users[id] = User.new
      end

      if @films[fid].nil?
        @films[fid] = Film.new
      end

      rating = $3.to_i

      @users[id].films[fid] = rating
      @films[fid].users[id] = rating

    else
      throw Error.new "Could not read user"
    end
  end

end

class User

  attr_accessor :films
  attr_accessor :friends

  def initialize
    @films = {}
    @friends = {}
  end

end

class Film

  attr_accessor :users

  def initialize
    @users = {}
  end

  def create_connections
    comb = {}
    @users.keys.combination(2) do |c|
      comb[c] = [(@users[c[0]]-@users[c[1]]).abs]
    end
    comb
  end
end

