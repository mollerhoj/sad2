require './lib/Node'
require './lib/Edge'
require './lib/Graph'
require './lib/LinKerlin'
require './lib/RatingParser'
require 'benchmark'

rp = RatingParser.new
g = nil

puts Benchmark.measure {
  g = rp.parse 'data/sample100000.dat'
}

lk = LinKerlin.new g
lk.N = 3
lk.random_partition

puts "compute_ds: " + Benchmark.measure {
  26.times do
    lk.compute_ds
  end
}.to_s

puts Benchmark.measure {
  puts "before: #{lk.calculate_t}"
}

puts "calc time:" + Benchmark.measure {
  lk.calculate
}.to_s

puts Benchmark.measure {
  puts "after: #{lk.calculate_t}"
}

