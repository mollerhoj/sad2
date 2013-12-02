require "Node"
require "Edge" 

class Graph

  attr_accessor :nodes
  attr_accessor :edges

  def initialize
    @nodes = []
    @edges = []
  end

  def add_edge edge
    @edges << edge
    add_edge_to_its_nodes edge
    edge
  end 

  def A
    return @nodes.select {|n| n.owner == :A}
  end

  def B
    return @nodes.select {|n| n.owner == :B}
  end

  def X
    return @nodes.select {|n| n.value == :A}
  end

  def Y
    return @nodes.select {|n| n.value == :B}
  end

  def edges_between nodes
    edges = []
    edges += nodes[0].out.select{|e| e.to == nodes[1]}
    edges += nodes[1].out.select{|e| e.to == nodes[0]}
    edges
  end

  def A_free
    return @nodes.select {|n| n.owner == :A and n.free?}
  end

  def B_free
    return @nodes.select {|n| n.owner == :B and n.free?}
  end

  def add_node node
    @nodes << node
    node
  end

  def to_s
    @edges.inject("\n") do |str,edge|
      str = str + edge.to_s + "\n"
    end
  end

  private
  def add_edge_to_its_nodes edge
    edge.from.out << edge
    edge.to.in << edge
  end

end
