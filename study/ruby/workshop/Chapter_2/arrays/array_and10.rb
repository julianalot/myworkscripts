my_array = ["a","b","c","d","e"]
my_array.each_with_index do |element, index|
puts "#{element} => #{index + 10}"
end