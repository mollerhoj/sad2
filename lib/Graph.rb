require "Node"
require "Edge" 

class Graph

  attr_accessor :nodes
  attr_accessor :edges

  def initialize
    @nodes = [] 
    @edges = []
  end

  def build_edges(list)
    list.each do |vec|
      build_edge vec[0],vec[1]
    end
  end

  def build_nodes(list)
    list.each do |vec|
      build_node vec[0],vec[1]
    end
  end

  def build_edge from_id, to_id
    from = build_node from_id
    to = build_node to_id
    add_edge Edge.new(from,to)
  end

  def build_node id,value=nil
    if not @nodes[id]
      @nodes[id] = Node.new id,value
    end
    @nodes[id]
  end

  def add_edge edge
    @edges << edge
    edge.to.in << edge
    edge.from.out << edge
  end 

  def to_s
    @edges.inject("\n") do |str,edge|
      str = str + edge.to_s + "\n"
    end
  end

end
