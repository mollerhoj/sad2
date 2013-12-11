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

    graph.add_edge Edge.new([n0,n1],weight: 3)
    graph.add_edge Edge.new([n2,n1],weight: 1)
    graph.add_edge Edge.new([n2,n3],weight: 7)
    graph.add_edge Edge.new([n3,n4],weight: 6)
    graph.add_edge Edge.new([n4,n5],weight: 2)
    graph.add_edge Edge.new([n3,n6],weight: 8)
    graph.add_edge Edge.new([n7,n6],weight: 4)
    graph.add_edge Edge.new([n7,n4],weight: 2)
    graph.add_edge Edge.new([n7,n5],weight: 4)
  end

  context "build a graph" do
    it "should build a simple graph" do
      graph2 = Graph.new
      graph2.b_nodes([0,:A],[1,:B],[2,:A],[3,:B],[4,:A])
      graph2.b_edges([0,1, w:3], [1,2, w:1], [2,3, w:4], [2,4, w:8])
      graph2.nodes.size.should eq(5)
    end
  end

  context "calculate" do
    it "should partition the graph" do
      graph2 = Graph.new
      graph2.b_edges([0,1, w:3], [2,1, w:1], [2,3, w:7], [3,4, w:6], [4,5, w:2],[3,6, w:8],[7,6, w:4],[7,4, w:2],[7,5, w: 4])
      lk2 = LinKerlin.new graph2
      lk2.N = 4
      #graph2
      lk2.random_partition
      lk2.compute_ds
      swaps = lk2.calculate
      #graph2
    end

    it "should partition the big graph" do
      graph2 = Graph.new
      graph2.b_edges(
        [0,1, w:3],[1,2, w:3],[2,3, w:3],[3,4, w:3],
        [5,6, w:3],[6,7, w:3],[7,8, w:3],[8,9, w:3],
        [10,11, w:3],[11,12, w:3],[12,13, w:3],[13,14, w:3],
        [15,16, w:3],[16,17, w:3],[17,18, w:3],[18,19, w:3],
        [20,21, w:3],[21,22, w:3],[22,23, w:3],[23,24, w:3],
        [0,5, w:3],[5,10, w:3],[10,15, w:3],[15,20, w:3],
        [1,6, w:3],[6,11, w:3],[11,16, w:3],[16,21, w:3],
        [2,7, w:3],[7,12, w:3],[12,17, w:3],[17,22, w:3],
        [3,8, w:3],[8,13, w:3],[13,18, w:3],[18,23, w:3],
        [4,9, w:3],[9,14, w:3],[14,19, w:3],[19,24, w:3]
      )

      lk2 = LinKerlin.new graph2
      lk2.N = 4
      # graph2
      lk2.random_partition
      lk2.compute_ds
      swaps = lk2.calculate
      #graph2
    end

    # -1
    # 00 0
    # 01 1
    # 10 2
    # 11 3
    #
    # 2^round
    #
    #        +0,+4
    #        000 0
    #   0,2  100 4
    #   00 0 010 2
    # 0 10 2 110 6
    #
    # 1 11 3 001 1
    #   01 1 101 5
    #        011 3
    #        111 7
    #
    

    it "should 4-way partition the big graph" do
      graph2 = Graph.new
      graph2.b_edges(
        [0,1, w:3],[1,2, w:3],[2,3, w:3],[3,4, w:3],
        [5,6, w:3],[6,7, w:3],[7,8, w:3],[8,9, w:3],
        [10,11, w:3],[11,12, w:3],[12,13, w:3],[13,14, w:3],
        [15,16, w:3],[16,17, w:3],[17,18, w:3],[18,19, w:3],
        [20,21, w:3],[21,22, w:3],[22,23, w:3],[23,24, w:3],
        [0,5, w:3],[5,10, w:3],[10,15, w:3],[15,20, w:3],
        [1,6, w:3],[6,11, w:3],[11,16, w:3],[16,21, w:3],
        [2,7, w:3],[7,12, w:3],[12,17, w:3],[17,22, w:3],
        [3,8, w:3],[8,13, w:3],[13,18, w:3],[18,23, w:3],
        [4,9, w:3],[9,14, w:3],[14,19, w:3],[19,24, w:3]
      )

      lk2 = LinKerlin.new graph2
      lk2.N = 4
      # graph2
      lk2.random_partition
      lk2.compute_ds
      swaps = lk2.calculate
      #graph2
    end


  end

  context "linkerlin step" do
    it "should store 1 swap" do
      graph2 = Graph.new
      graph2.b_nodes([0,:A],[1,:B],[2,:A],[3,:B],[4,:A],[5,:B],[6,:A],[7,:B])
      graph2.b_edges([0,1, w:3], [2,1, w:1], [2,3, w:7], [3,4, w:6], [4,5, w:2],[3,6, w:8],[7,6, w:4],[7,4, w:2],[7,5, w: 4])

      a = [-3,-2,-6,-5,-6,2,4,2]
      graph2.nodes.each_with_index.map {|n,i| n.d = a[i]}

      lk2 = LinKerlin.new graph2
      lk2.N = 4
      #graph2
      swaps = lk2.lin_kerlin_step
      #graph2
    end

    it "should take steps" do
      graph2 = Graph.new
      graph2.b_nodes([0,:A],[1,:A],[2,:A],[3,:A],[4,:B],[5,:B],[6,:B],[7,:B])
      graph2.b_edges([0,1, w:2], [1,2, w:1], [2,3, w:2], [4,5, w:2], [5,6, w:1],
                     [6,7, w:2], [0,4, w:2], [1,5, w:2], [2,6, w:2], [3,7, w:2])

      a = [0,-1,-1,0,0,-1,-1,0]
      graph2.nodes.each_with_index.map {|n,i| n.d = a[i]}

      lk2 = LinKerlin.new graph2
      lk2.N = 4
      swaps = lk2.lin_kerlin_step

      graph2.nodes[0].value.should eq(1)
      graph2.nodes[1].value.should eq(1)
      graph2.nodes[2].value.should eq(0)
      graph2.nodes[3].value.should eq(0)
      graph2.nodes[4].value.should eq(1)
      graph2.nodes[5].value.should eq(1)
      graph2.nodes[6].value.should eq(0)
      graph2.nodes[7].value.should eq(0)
    end

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
    it "should store 3 swap values" do
      graph2 = Graph.new
      graph2.b_nodes([0,:A,1],[1,:B,0],[2,:B,1],[3,:B,1],[4,:B,1],[5,:B],[6,:A],[7,:B])
      graph2.b_edges([0,1, w:3], [2,1, w:1], [2,3, w:7], [3,4, w:6], [4,5, w:2],[3,6, w:8],[7,6, w:4],[7,4, w:2],[7,5, w: 4])
      swaps = []
      swaps << Swap.new([graph2.nodes[2],graph2.nodes[1]])
      swaps << Swap.new([graph2.nodes[4],graph2.nodes[7]])
      swaps << Swap.new([graph2.nodes[0],graph2.nodes[3]])
      swaps << Swap.new([graph2.nodes[5],graph2.nodes[6]])
      graph2.nodes[0].value.should eq(1)
      graph2.nodes[1].value.should eq(0)
      graph2.nodes[4].value.should eq(1)
      graph2.nodes[5].value.should eq(1)
      lk2 = LinKerlin.new graph2
      lk2.save_swaps(swaps,3)
      graph2.nodes[0].value.should eq(0)
      graph2.nodes[1].value.should eq(1)
      graph2.nodes[4].value.should eq(1)
      graph2.nodes[5].value.should eq(1)
    end
  end

  context "execute the best swap(s)" do
    it "should return a list of swaps" do
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
      lk.N = 3
      swaps = lk.execute_N_best_swaps
      swaps[0].a.should eq(n6)
      swaps[0].b.should eq(n5)
      swaps[0].gain.should eq(6)
      swaps[1].gain.should eq(-4)
      swaps[2].gain.should eq(-5)
    end

    it "should swaps owners with highest gain" do
      n0.owner = :A
      n1.owner = :A
      n2.owner = :B
      n3.owner = :B
      n0.d = 3
      n1.d = 2
      n2.d = 6
      n3.d = 7
      lk.execute_best_swap
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

    it "d values should set to nil" do
      lk.compute_d n1
      lk.compute_d n2
      lk.compute_d n3
      lk.execute_swap swap
      n0.d.should eq(nil)
      n1.d.should eq(nil)
      n2.d.should eq(nil)
      n3.d.should eq(nil)
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

  context "The d for a node" do
    it "Should compute the d for the node" do
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

  it "Should compute the t of a graph" do
    graph2 = Graph.new
    graph2.b_nodes([0,:A],[1,:A],[2,:B],[3,:A],[4,:A])
    graph2.b_edges([0,1, w:3], [1,2, w:1], [2,3, w:4], [3,4, w:8])
    lk2 = LinKerlin.new graph2
    lk2.calculate_t.should eq(5)
  end

end
