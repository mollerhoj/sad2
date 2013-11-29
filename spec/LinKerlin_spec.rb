require 'Spec_helper'

describe LinKerlin do
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
    graph.add_edge Edge.new([n0,n1],3)
    graph.add_edge Edge.new([n1,n2],1)
    graph.add_edge Edge.new([n2,n3],7)
  end

  context "execute the best swap" do
    it "should return the graph after best swap" do
      pending
      n0.owner = :A
      n1.owner = :A
      n2.owner = :B
      n3.owner = :B
      n0.d = 3
      n1.d = 2
      n2.d = 6
      n3.d = 7

      lk = LinKerlin.new
      graph_new = lk.execute_best_swap(graph)
      #graph_new.t.should eq(4)
      n0.owner.should eq(:B)
      n3.owner.should eq(:A)

    end
  end

  context "find weight between nodes" do
    it "should return the weight between two nodes" do
      lk = LinKerlin.new
      lk.weight_between([n0,n1],graph).should eq(3)
      lk.weight_between([n0,n2],graph).should eq(0)
      lk.weight_between([n3,n2],graph).should eq(7)
    end
  end

  context "find best swap" do
    it "should return the best possible swap" do
      n0.owner = :A
      n1.owner = :A
      n2.owner = :B
      n3.owner = :B
      n0.d = 3
      n1.d = 2
      n2.d = 6
      n3.d = 7

      lk = LinKerlin.new
      swap = lk.best_swap(graph)
      swap.a.should eq(n3)
      swap.b.should eq(n0)
      swap.gain.should eq(10)
    end
  end

  context "execute a swap" do
    it "nodes should have switched owners" do
      n0.owner = :A
      n2.owner = :B

      lk = LinKerlin.new
      swap = Swap.new([n0,n2])
      graph_new = lk.execute_swap(graph,swap)
      graph_new.nodes[0].owner.should eq(:B)
    end

    it "nodes should be marked" do
      pending
    end

    it "d values should be recomputed" do
      pending
    end

    it "graph t value should be recomputed" do
      pending
    end
  end

  context "A random partition" do
    it "should divide the graph in two equal sets" do
      lk = LinKerlin.new
      graph_new = lk.random_partition(graph)

      graph_new.A.size.should eq(graph_new.B.size)
      graph_new.A.size.should eq(2)
    end
  end

  context "The d value for a node" do
    it "Should compute the value of d for the node" do
      n0.owner,n1.owner = :A,:A
      n2.owner,n3.owner = :B,:B

      lk = LinKerlin.new
      lk.compute_d(n0).should eq(3)
      lk.compute_d(n1).should eq(2)
      lk.compute_d(n2).should eq(6)
      lk.compute_d(n3).should eq(7)
    end
  end
end
