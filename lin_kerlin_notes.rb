# A,B graph split
# g: gain
# g_max: maximal gain
# N: number of swaps to do max=(|V|/2)

#it should return the graph after running the kernighan_lin algoritm
def kernighan_lin graph n
  if n.nil?
    n = graph.nodes_n/2
  end
  graph = random_partition graph
  graph.t = 0 #relative t value
  kernighan_lin_loop graph n
end

#helper
def kernighan_lin_loop graph n
  loop do
    new_graph = compute_swaps graph n
    if new_graph
      graph = new_graph
    else
      break
    end
  end
end

#it should return the graph after doing the best possible swaps,
#trying N moves
def compute_swaps graph, n
  t_max = 0
  best_graph = nil
  n.times do |n|
    graph = compute_swap(graph)
    if graph.t > t_max 
      t_max = graph.t
      best_graph = graph
    end
  end
  return best_graph
end

# it should return the graph after doing the best possible swap
def execute_best_swap graph
  gain,swap = execute_swap graph
  compute_swap
end

#It should return the graph after doing a swap
def execute_swap graph, swap
  mark {a,b}
  swap a,b
  compute_d {a,b}
  graph.t += swap.gain
  return graph
end

# By lemma 1, maximise the gain
# Note: Gain is not always positive, hence algoritm might look ahead.
# it should return the swap resulting in the biggest gain
def best_swap graph
  swap.gain = MIN
  A.each do |a|
    B.each do |b|
      d = a.d + b.d - 2*c(a,b)
      if d > swap.gain
        swap.gain = d
        swap = a,b
      end
    end
  end
  return swap
end

def compute_d nodes
  nodes.each do |node|
    node.d = internal - external
  end
end

def random_partition graph
  graph.nodes.each do |node|
    if node.id % 2 == 0
      node.owner = :a
    else
      node.owner = :b
    end
  end
end

=begin
function Kernighan-Lin(G(V,E)):
 2      determine a balanced initial partition of the nodes into sets A and B
 3      A1 := A; B1 := B
 4      do
 5         compute D values for all a in A1 and b in B1
 6         for (n := 1 to |V|/2)
 7            find a[i] from A1 and b[j] from B1, such that g[n] = D[a[i]] + D[b[j]] - 2*c[a[i]][b[j]] is maximal
 8            move a[i] to B1 and b[j] to A1
 9            remove a[i] and b[j] from further consideration in this pass
 10           update D values for the elements of A1 = A1 \ a[i] and B1 = B1 \ b[j]
 11        end for
 12        find k which maximizes g_max, the sum of g[1],...,g[k]
 13        if (g_max > 0) then
 14           Exchange a[1],a[2],...,a[k] with b[1],b[2],...,b[k]
 15     until (g_max <= 0)
 16  return G(V,E)
=end
