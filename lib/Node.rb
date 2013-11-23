class Node

  attr_accessor :in
  attr_accessor :out
  attr_reader :id
  #custom_values
  attr_accessor :value

  def initialize id, value, edges=[]
    @id = id
    @edges = edges
    @in = []
    @out = []
    @value = value
  end
  
  def to_s
    "(#{@id.to_s})"
  end
  
end
