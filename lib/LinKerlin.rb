class LinKerlin

  attr_accessor :graph
  attr_accessor :N

  def initialize graph=nil
    @graph = graph
    @bw = {}
    @swaps_log = []
    @gains_log = []
    @sorted_head_log = []
  end

  def calculate_t
    t = 0
    graph.nodes.each do |n|
      t += external_d n
    end
    t/2
  end

  def random_partition (seed=nil)
    nodes_n = graph.nodes.size
    a_left = nodes_n / 2
    graph.nodes.each_with_index do |node,i|
      if rand(nodes_n-i) < a_left
        node.owner = :A
        node.value = 0
        a_left -=1
      else
        node.owner = :B
        node.value = 1
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
    @gains_log << gain_max.round(2)
    return swaps_n
  end

  def calculate
    while lin_kerlin_step
      compute_ds

    end
    puts @swaps_log.inspect
    puts @gains_log.inspect
    puts "av. ij " + (@sorted_head_log.inject(0.0) {|sum,e| sum+e} / @sorted_head_log.size).to_s
  end

  def lin_kerlin_step
    swaps = execute_N_best_swaps
    k = find_best_number_of_swaps swaps
    @swaps_log << k
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
      ## depending on round
      if swap.a.owner == :A
        swap.a.value = 0
      else
        swap.a.value = 1
      end
      if swap.b.owner == :A
        swap.b.value = 0
      else
        swap.b.value = 1
      end
    end
  end

  def clean_swaps swaps, k
    swaps.each do |swap|
      ## depending on round
      if swap.a.value == 0
        swap.a.owner = :A
      else
        swap.a.owner = :B
      end
      if swap.b.value == 0
        swap.b.owner = :A
      else
        swap.b.owner = :B
      end
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
      node.d = compute_d node
    end
    swap
  end

  def best_swap
    aa = graph.A_free.sort_by {|n| n.d}.reverse
    bb = graph.B_free.sort_by {|n| n.d}.reverse
    i = -1
    j = -1
    best = nil
    while(i < aa.size-2)
      i+=1
      for k in 0..j
        current = Swap.new([aa[i],bb[k]])
        current.gain = calc_gain aa[i],bb[k]
        if best.nil? or current.gain > best.gain
           best = current
        end
      end
      j+=1
      for k in 0..i
        current = Swap.new([aa[k],bb[j]])
        current.gain = calc_gain aa[k],bb[j]
        if best.nil? or current.gain > best.gain
           best = current
        end
      end
      if best.gain > aa[i].d + bb[j].d
        @sorted_head_log << i
        @sorted_head_log << j
        break
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
