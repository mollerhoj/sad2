require "Spec_helper"

describe Node do
  it "has neighbors" do
    graph = Graph.new

    n0 = graph.add_node Node.new(0)
    n1 = graph.add_node Node.new(1)
    graph.add_edge Edge.new([n0,n1],1)

    n0.neighbors.should eq([n1])
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
end
