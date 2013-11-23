class VertexCover
  def find graph
    untight = []
    graph.edges.each do |edge|
      edge.pay = 0
      untight << edge
    end

    until untight.empty?
      e = untight.first
      increase_pay e 
    end
  end

  private
  def increase_pay edge
    node = edge.min_by {|node| node.value }
    edge.pay = node.value

    edge.from.value - pay
    edge.to.value - pay
  end
end


=begin
foreach e in E 
 pe = 0 
 
 while (∃ edge i-j such that neither i nor j are tight) 
 select such an edge e 
 increase pe as much as possible until i or j tight 
 } 
 
 S ← set of all tight nodes 
 return S 
=end
