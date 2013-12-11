class LinKerlin

  attr_accessor :graph
  attr_accessor :N

  def initialize graph=nil
    @graph = graph
    @bw = {}
  end

  def calculate_t
    t = 0
    graph.nodes.each do |n|
      t += external_d n
    end
    t/2
  end

  def random_partition
    nodes_n = graph.nodes.size
    a_left = nodes_n / 2

    graph.nodes.each_with_index do |node,i|
      if rand(nodes_n-i) < a_left
        node.owner = node.value = :A
        a_left -=1
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

  def calculate
    while lin_kerlin_step
      compute_ds
      puts 'step'
    end
  end

  def lin_kerlin_step
    swaps = execute_N_best_swaps
    k = find_best_number_of_swaps swaps
    if k > 0
      store_swaps swaps, k
      true
    else
      false
    end
  end

  def execute_N_best_swaps
    swaps = []
    @N.times do
      swaps << execute_best_swap
    end
    swaps
  end

  def store_swaps swaps, k
    save_swaps swaps, k
    clean_swaps swaps, k
  end

  def save_swaps swaps, k
    swaps[0,k].each do |swap|
      swap.values = swap.owners
    end
  end

  def clean_swaps swaps, k
    swaps.each do |swap|
      swap.owners = swap.values
    end
    swaps.each do |swap|
      swap.unmark
    end
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
      node.d = nil
    end
    swap
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
    if best.nil?
      puts "no free nodes"
    end
    return best
  end

  # move to swap
  def calc_gain a,b
    if a.d.nil?
      compute_d a
    end
    if b.d.nil?
      compute_d b
    end
    a.d + b.d - 2*weight_between([a,b])
  end

  def weight_between nodes
    @bw[nodes] ||=
    nodes[0].edges_to(nodes[1]).inject(0) do |weight,edge| ####!
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
      if node.owner != source.owner ##!
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

  def unmark
    @a.unmark
    @b.unmark
  end

  def switch_owners
    @a.owner, @b.owner = @b.owner, @a.owner
  end

  def values=(v)
    @a.value=v[0]
    @b.value=v[1]
  end

  def owners=(o)
    @a.owner=o[0]
    @b.owner=o[1]
  end

  def values
    [@a.value,@b.value]
  end

  def owners
    [@a.owner,@b.owner]
  end

  def initialize nodes, gain=nil
    @a = nodes[0]
    @b = nodes[1]
    @gain = gain
  end

  def to_s
    "#{@a} <- #{@gain} -> #{@b}"
  end
end
