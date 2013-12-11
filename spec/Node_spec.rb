require "Spec_helper"

describe Node do
  it "has neighbors" do
    graph = Graph.new

    n0 = graph.add_node Node.new(0)
    n1 = graph.add_node Node.new(1)
    graph.add_edge Edge.new([n0,n1],weight: 1)

    n0.neighbors.should eq([n1])
  end

  it "has edges to other nodes" do
    graph = Graph.new

    n0 = graph.add_node Node.new(0)
    n1 = graph.add_node Node.new(1)
    n2 = graph.add_node Node.new(2)
    e1 = Edge.new([n0,n1],weight: 3)
    e2 = Edge.new([n1,n2],weight: 3)
    graph.add_edge e1
    graph.add_edge e2

    n0.edges_to(n1).should eq([e1])
    n0.edges_to(n2).should eq([])
    n1.edges_to(n2).should eq([e2])
  end

  it "can hold a d value" do
    n = Node.new(0)
    n.d = 7
    n.d.should eq(7)
  end

  it "can be marked not free" do
    n = Node.new(0)
    n.free?.should eq(true)
    n.mark
    n.free?.should eq(false)
  end

  context "has edges" do
    let(:graph) {Graph.new}
    let(:n0) {graph.nodes[0]}
    let(:n1) {graph.nodes[1]}
    let(:n2) {graph.nodes[2]}
    let(:n3) {graph.nodes[3]}

    before(:each) do
      graph.add_node Node.new(0)
      graph.add_node Node.new(1)
      graph.add_node Node.new(2)
      graph.add_node Node.new(3)
      graph.add_edge Edge.new([n0,n1],weight: 3)
      graph.add_edge Edge.new([n1,n2],weight: 1)
      graph.add_edge Edge.new([n3,n1],weight: 6)
      graph.add_edge Edge.new([n2,n3],weight: 7)
    end

    it "has neighbors" do
      n1.neighbors.should eq([n2,n0,n3])
    end

    it "has out" do
      n1.out.size.should eq(1)
    end

    it "has in" do
      n1.in.size.should eq(2)
    end

    it "has edges" do
      n1.edges.size.should eq(3)
    end

    it "has relations" do
      n1.relations.size.should eq(3)
    end
  end
end
