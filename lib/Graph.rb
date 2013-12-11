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

  def build &block
    self.instance_eval &block
  end

  #builds an edge
  def build_edge(i,j,hash)
    if nodes[i].nil?
      nodes[i] = Node.new(i)
    end
    if nodes[j].nil?
      nodes[j] = Node.new(j)
    end
    hash[:weight] = hash[:w]
    add_edge Edge.new([nodes[i],nodes[j]],hash)
  end

  def b_edges *edges
    edges.each do |e|
      build_edge e[0],e[1],e[2]
    end
  end

  def b_nodes *ns
    ns.each do |n|
      @nodes[n[0]] = Node.new(n[0])
      @nodes[n[0]].owner = n[1]

      if @nodes[n[0]].owner == :A
        @nodes[n[0]].value = 0
      end

      if @nodes[n[0]].owner == :B
        @nodes[n[0]].value = 1
      end

      if not n[2].nil?
        @nodes[n[0]].value = n[2]
      end
    end
  end

  def A
    return @nodes.select {|n| n.owner == :A}
  end

  def B
    return @nodes.select {|n| n.owner == :B}
  end

  def X
    return @nodes.select {|n| n.value == 0}
  end

  def Y
    return @nodes.select {|n| n.value == 1}
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
