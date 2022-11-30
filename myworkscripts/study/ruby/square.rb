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
  
def perimeter
  @side_length * 4
end

end

my_square = Square.new(10)

puts my_square.perimeter

