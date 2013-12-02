require 'Spec_helper'

describe LinKerlin do
  let(:graph) {Graph.new}
  let(:n0) {graph.nodes[0]}
  let(:n1) {graph.nodes[1]}
  let(:n2) {graph.nodes[2]}
  let(:n3) {graph.nodes[3]}
  let(:n4) {graph.nodes[4]}
  let(:n5) {graph.nodes[5]}
  let(:n6) {graph.nodes[6]}
  let(:n7) {graph.nodes[7]}
  let(:lk) {LinKerlin.new graph}

  # 3   2   6   5   6   -2
  # a-3-a-1-b-7-b-6-b-2-b
  #             8\  2\ 4|
  #               a-4-a/
  #              -4  -2
  before(:each) do
    graph.add_node Node.new(0)
    graph.add_node Node.new(1)
    graph.add_node Node.new(2)
    graph.add_node Node.new(3)
    graph.add_node Node.new(4)
    graph.add_node Node.new(5)
    graph.add_node Node.new(6)
    graph.add_node Node.new(7)
    graph.add_edge Edge.new([n0,n1],3)
    graph.add_edge Edge.new([n2,n1],1)
    graph.add_edge Edge.new([n2,n3],7)
    graph.add_edge Edge.new([n3,n4],6)
    graph.add_edge Edge.new([n4,n5],2)
    graph.add_edge Edge.new([n3,n6],8)
    graph.add_edge Edge.new([n7,n6],4)
    graph.add_edge Edge.new([n7,n4],2)
    graph.add_edge Edge.new([n7,n5],4)
  end

  context "find best number of swaps" do
    it "should return the number of swaps with highest gain" do
      swaps = []
      swaps << Swap.new([n0,n1],4)
      swaps << Swap.new([n0,n1],-3)
      lk.find_best_number_of_swaps(swaps).should eq(1)
      swaps << Swap.new([n0,n1],2)
      swaps << Swap.new([n0,n1],2)
      swaps << Swap.new([n0,n1],-3)
      lk.find_best_number_of_swaps(swaps).should eq(4)
      swaps << Swap.new([n0,n1],4)
      lk.find_best_number_of_swaps(swaps).should eq(6)
    end
  end

  context "save swaps" do
    it "should store 2 swap values" do
      n0.owner = :A
      n0.value = :B
      n1.owner = :A
      n1.value = :B
      n2.owner = :B
      n3.owner = :B
      n4.owner = :B
      n4.value = :B
      n7.owner = :A
      swaps = []
      swaps << Swap.new([n2,n1])
      swaps << Swap.new([n0,n3])
      swaps << Swap.new([n4,n7])
      n0.value.should eq(:B)
      n1.value.should eq(:B)
      n4.value.should eq(:B)
      lk.save_swaps(swaps,2)
      n0.value.should eq(:A)
      n1.value.should eq(:A)
      n4.value.should eq(:B)
    end
  end

  context "execute the best swap" do
    it "should return the graph after best swap" do
      n0.owner = :A
      n1.owner = :A
      n2.owner = :B
      n3.owner = :B
      n0.d = 3
      n1.d = 2
      n2.d = 6
      n3.d = 7
      graph_new = lk.execute_best_swap
      n0.owner.should eq(:B)
      n3.owner.should eq(:A)
    end

    it "does not swap marked nodes" do
      n0.owner = :A
      n1.owner = :A
      n2.owner = :B
      n3.owner = :B
      n0.d = 3
      n1.d = 2
      n2.d = 6
      n3.d = 7
      n0.mark
      n2.mark
      lk.execute_best_swap
      n0.owner.should eq(:A)
      n2.owner.should eq(:B)
      n1.owner.should eq(:B)
      n3.owner.should eq(:A)
    end
  end

  context "find weight between nodes" do
    it "should return the weight between two nodes" do
      lk.weight_between([n0,n1]).should eq(3)
      lk.weight_between([n0,n2]).should eq(0)
      lk.weight_between([n3,n2]).should eq(7)
    end
  end

  context "find best swap" do
    it "should return the best possible swap" do
      n0.owner = :A
      n1.owner = :A
      n2.owner = :B
      n3.owner = :B
      n4.owner = :B
      n5.owner = :B
      n6.owner = :A
      n7.owner = :A
      n0.d = -3
      n1.d = -2
      n2.d = -6
      n3.d = -5
      n4.d = -6
      n5.d = 2
      n6.d = 4
      n7.d = 2
      swap = lk.best_swap
      swap.a.should eq(n6)
      swap.b.should eq(n5)
      swap.gain.should eq(6)
    end
  end

  context "execute a swap" do
    before(:each) do
      n0.owner = :A
      n1.owner = :A
      n2.owner = :B
      n3.owner = :B
      n4.owner = :B
      n5.owner = :B
      n6.owner = :A
      n7.owner = :A
      n0.d = 3
      n1.d = 2
      n2.d = 6
      n3.d = 5
      n4.d = 6
      n5.d = -2
      n6.d = -4
      n7.d = -2
    end

    let(:swap) { Swap.new([n0,n2]) }

    it "nodes should have switched owners" do
      lk.execute_swap swap
      n0.owner.should eq(:B)
      n2.owner.should eq(:A)
    end

    it "nodes should be marked" do
      n0.free?.should eq(true)
      lk.execute_swap swap
      n0.free?.should eq(false)
    end

    it "d values should be recomputed" do
      lk.compute_d n1
      lk.compute_d n2
      lk.compute_d n3
      lk.execute_swap swap
      n0.d.should eq(3)
      n1.d.should eq(2)
      n2.d.should eq(6)
      n3.d.should eq(9)
    end
  end

  context "A random partition" do
    it "should divide the graph in two equal sets" do
      lk.random_partition

      graph.A.size.should eq(graph.B.size)
      graph.A.size.should eq(4)

      graph.X.size.should eq(graph.Y.size)
      graph.X.size.should eq(4)
    end
  end

  context "The d value for a node" do
    it "Should compute the value of d for the node" do
      n0.owner,n1.owner = :A,:A
      n2.owner,n3.owner = :B,:B
      n4.owner,n5.owner = :B,:B
      n6.owner,n7.owner = :A,:A
      lk.compute_d(n0).should eq(-3)
      lk.compute_d(n1).should eq(-2)
      lk.compute_d(n2).should eq(-6)
      lk.compute_d(n3).should eq(-5)
      lk.compute_d(n4).should eq(-6)
      lk.compute_d(n5).should eq(2)
      lk.compute_d(n6).should eq(4)
      lk.compute_d(n7).should eq(2)
    end
  end
end
