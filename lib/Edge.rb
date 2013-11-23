class Edge

  attr_accessor :from
  attr_accessor :to

  #custom values:
  attr_accessor :pay

  def initialize(from,to)
    @from = from
    @to = to
  end

  def to_s
    "#{@from}-#{@to}"
  end

  def min_by
    if yield(@from) < yield(@to)
      return @from
    else
      return @to
    end
  end

end
