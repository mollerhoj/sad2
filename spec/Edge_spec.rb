require "Spec_helper"

describe Edge do
  describe "min_by method"
  context "nodes with values 0 and 1" do
    it "should return node with value 0" do
      n1 = Node.new(0,1)
      n2 = Node.new(1,0)
      e = Edge.new(n1,n2)
      res = e.min_by {|node| node.value}
      res.id.should eq(1)
    end
  end

  context "nodes with values -5 and 77" do
    it "should return node with value -5" do
      n1 = Node.new(6,-5)
      n2 = Node.new(10,77)
      e = Edge.new(n1,n2)
      res = e.min_by {|node| node.value}
      res.id.should eq(6)
    end
  end
end
      
