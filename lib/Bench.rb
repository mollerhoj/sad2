require './lib/Node'
require './lib/Edge'
require './lib/Graph'
require './lib/LinKerlin'
require './lib/RatingParser'
require 'benchmark'

rp = RatingParser.new
g = nil

puts Benchmark.measure {
  g = rp.parse "data/sample#{ARGV[0].to_i}.dat"
}

puts "nodes#{g.nodes.size}, edges #{g.edges.size}"

lk = LinKerlin.new g
lk.N = ARGV[1].to_i

min_t = nil
min_s = nil
puts "Z: "
puts Benchmark.measure {
  ARGV[2].to_i.times do |i|
    s = Random.new_seed
    srand s
    lk.random_partition
    t = lk.calculate_t
    if min_t.nil? or t < min_t
      min_t = t
      min_s = s
    end
  end
}

srand min_s
lk.random_partition

lk.compute_ds

Benchmark.measure {
  puts "before: #{lk.calculate_t}"
}

puts "calc time:" + Benchmark.measure {
  lk.calculate
}.to_s

Benchmark.measure {
  puts "after: #{lk.calculate_t}"
}

