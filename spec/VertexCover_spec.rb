require 'Spec_helper'

describe VertexCover do
  describe "Find a Vertex Cover" do
    context "An empty graph" do
      it "should return 0 nodes" do
        pending
        vc = VertexCover.new
        graph = Graph.new
        vc.find(graph).should eq([])
      end
    end

    context "A simple graph" do
      it "should return 2 nodes" do
        pending
        vc = VertexCover.new
        graph = Graph.new
        graph.build_nodes([[0,2],[1,4],[2,2],[3,9]])
        graph.build_edges([[0,1],[0,2],[0,3],[1,3],[2,3]])
        vc.find(graph).should eq([0,3])
      end
    end

  end
end
