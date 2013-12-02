class LinKerlin

  attr_accessor :graph
  attr_accessor :N

  def initialize graph=nil
    @graph = graph
  end

  def random_partition
    graph.nodes.each do |node|
      if node.id%2 == 0
        node.owner = node.value = :A
      else
        node.owner = node.value = :B
      end
    end
    graph
  end

  def compute_ds
    graph.nodes.each do |node|
      compute_d node
    end
  end

  #build sum array.
  #find max of sums.
  def find_best_number_of_swaps swaps
    swaps_n = gain_sum = gain_max = 0

    swaps.each_with_index do |swap,i|
      gain_sum+= swap.gain
      if gain_sum > gain_max
        gain_max = gain_sum
        swaps_n = i+1
      end
    end

    return swaps_n
  end

  def lin_kerlin
    #partition
    #while lin_kerlin_step do end
  end

  def lin_kerlin_step
    # swaps = []
    # N.times do
    #   swaps << execute_best_swap
    # end
    # k = find_best_number_of_swaps swaps
    # if k > 0
    #   save_swaps swaps k
    #   clean_swaps swaps
    #   true
    # else
    #   false
    # end
  end

  def save_swaps swaps, k
    #only to k!
    swaps.each do |swap|
      swap.values = swap.owners
    end
  end

  def clean_swaps swaps
    # swaps.each do |swap|
    #   swap.switch_owners
    #   swap.unmark
    # end
  end

  def execute_best_swap
    swap = best_swap
    execute_swap swap
  end

  def execute_swap swap
    swap.mark
    swap.switch_owners
    recompute = [swap.a,swap.b] + swap.a.neighbors + swap.b.neighbors
    recompute.each do |node|
      compute_d node
    end
  end

  def best_swap
    best = nil
    graph.A_free.each do |a|
       graph.B_free.each do |b|
         current = Swap.new([a,b])
         current.gain = calc_gain a,b
         if best.nil? or current.gain > best.gain
           best = current
         end
       end
    end
    return best
  end

  # move to swap
  def calc_gain a,b
    a.d + b.d - 2*weight_between([a,b])
  end

  def weight_between nodes
    graph.edges_between(nodes).inject(0) do |weight,edge|
      weight += edge.weight
    end
  end

  #move to node
  def compute_d node
    node.d = external_d(node) - internal_d(node)
  end

  def internal_d source
    count = 0
    source.relations.each do |node,edge|
      if node.owner == source.owner
        count += edge.weight
      end
    end
    count
  end

  def external_d source
    count = 0
    source.relations.each do |node,edge|
      if node.owner != source.owner
        count += edge.weight
      end
    end
    count
  end

end

class Swap
  attr_accessor :a
  attr_accessor :b
  attr_accessor :gain

  def mark
    @a.mark
    @b.mark
  end

  def switch_owners
    @a.owner, @b.owner = @b.owner, @a.owner
  end

  def values=(v)
    @a.value=v[0]
    @b.value=v[1]
  end

  def owners
    [@a.owner,@b.owner]
  end

  def initialize nodes, gain=nil
    @a = nodes[0]
    @b = nodes[1]
    @gain = gain
  end
end

# A,B graph split
# g: gain
# g_max: maximal gain
# N: number of swaps to do max=(|V|/2)

# #it should return the graph after running the kernighan_lin algoritm
# def kernighan_lin graph n
#   if n.nil?
#     n = graph.nodes_n/2
#   end
#   graph = random_partition graph
#   graph.t = 0 #relative t value
#   kernighan_lin_loop graph n
# end
# 
# #helper
# def kernighan_lin_loop graph n
#   loop do
#     new_graph = compute_swaps graph n
#     if new_graph
#       graph = new_graph
#     else
#       break
#     end
#   end
# end
