class Edge

  attr_accessor :from
  attr_accessor :to

  #custom values:
  attr_accessor :pay
  attr_accessor :weight

  def initialize(dest,hash=nil)
    @from = dest[0]
    @to = dest[1]
    if not hash.nil?
      @weight = hash[:weight]
    end
  end

  def to_s
    if not weight
      "#{@from}---#{@to}"
    else
      "#{@from}-#{weight}-#{@to}"
    end
  end

  def min_by
    if yield(@from) < yield(@to)
      return @from
    else
      return @to
    end
  end

end
