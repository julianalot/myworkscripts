system "clear"

class Square

  def initialize(side_length)
    @side_length = side_length
  end

  def side_length
    return @side_length
  end

  def side_length =( side_length)
    @side_length = side_length
  end
  
end

#my_square = Square.new(10)
