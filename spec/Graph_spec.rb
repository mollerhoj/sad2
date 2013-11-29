require "Spec_helper"

describe Graph, "add_node" do
  it "adds the node, and returns it" do
    graph = Graph.new
    n0 = graph.add_node Node.new(0)
    graph.nodes[0] = n0
  end

  it "has sets A and B of nodes" do
    graph = Graph.new
    n0 = graph.add_node Node.new(0)
    n0.owner = :A
    n1 = graph.add_node Node.new(1)
    n1.owner = :B
    n2 = graph.add_node Node.new(2)
    n2.owner = :B

    graph.A.should eq([n0])
    graph.B.should eq([n1,n2])
  end

  it "has sets A_free and B_free of nodes" do
    graph = Graph.new
    n0 = graph.add_node Node.new(0)
    n0.owner = :A
    n1 = graph.add_node Node.new(1)
    n1.owner = :B
    n2 = graph.add_node Node.new(2)
    n2.owner = :B
    n1.mark

    graph.A_free.should eq([n0])
    graph.B_free.should eq([n2])
  end

  it "finds the edge between two nodes" do
    graph = Graph.new
    n0 = Node.new(0)
    n1 = Node.new(1)
    n2 = Node.new(2)
    n3 = Node.new(3)
    graph.add_node n0
    graph.add_node n1
    graph.add_node n2
    graph.add_node n3
    e0 = graph.add_edge Edge.new([n0,n1])
    e1 = graph.add_edge Edge.new([n1,n2])
    e2 = graph.add_edge Edge.new([n3,n2])
    graph.edges_between([n0,n1]).should eq([e0])
    graph.edges_between([n1,n2]).should eq([e1])
    graph.edges_between([n2,n3]).should eq([e2])
  end

  it "adds edge to the graph and returns it" do
    graph = Graph.new
    n0 = Node.new(0)
    n1 = Node.new(1)
    e = Edge.new([n0,n1])
    graph.add_node n0
    graph.add_node n1
    f = graph.add_edge e
    graph.edges[0].should eq(e)
    f.should eq(e)
  end
end
