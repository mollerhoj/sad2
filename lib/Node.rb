class Node

  attr_accessor :in
  attr_accessor :out
  attr_reader :id
  #custom_values
  attr_accessor :owner
  attr_accessor :value
  attr_accessor :d

  def initialize id
    @id = id
    @in = []
    @out = []
    @free = true
    @et = {}
  end

  def edges
    @in + @out
  end

  def relations
    @relations ||= relations_in + relations_out
  end

  def relations_out
    @out.inject([]) do |rel,e|
      rel << [e.to,e]
    end
  end

  def relations_in
    @in.inject([]) do |rel,e|
      rel << [e.from,e]
    end
  end

  def mark
    @free = false
  end

  def unmark
    @free = true
  end

  def free?
    @free
  end
  
  def neighbors
    n = []
    @out.each do |edge|
      n << edge.to
    end
    @in.each do |edge|
      n << edge.from
    end
    n
  end

  def edges_to other
    if !@et[other].nil?
      @et[other]
    else
      @et[other] = edges_to_helper other
    end
  end

  def edges_to_helper other
    relations.inject([]) do |p,r|
      p << r[1] if r[0] == other
      p
    end
  end
  
  def to_s
    if not owner
      "( #{@id.to_s})"
    else
      "(#{@owner.to_s}/#{@value.to_s}#{@id.to_s})"
    end
  end
  
end
